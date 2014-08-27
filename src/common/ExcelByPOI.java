package common;

/**
 * add by huyf
 */
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.Region;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.RichTextString;

/**
 * <pre>
 * POI——Excel操作クラス。
 * </pre>
 * 
 * @page common
 * @author common
 * @version 1.0.0
 */
public class ExcelByPOI {

	private HSSFWorkbook wb;

	private static final SimpleDateFormat FULLTIMEFMT = new SimpleDateFormat(
			"yyyy-MM-dd HH:mm:ss");

	// private static final SimpleDateFormat FULLDATEFMT = new
	// SimpleDateFormat("yyyy-MM-dd");

	/**
	 * @param is
	 *            InputStream
	 */
	public ExcelByPOI(InputStream is) {

		POIFSFileSystem fs;
		try {
			fs = new POIFSFileSystem(is);
			wb = new HSSFWorkbook(fs);
		} catch (FileNotFoundException e) {
			throw new RuntimeException(e);
		} catch (IOException e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * @param filePath
	 *            String
	 */
	public ExcelByPOI(String filePath) {

		POIFSFileSystem fs;
		try {
			fs = new POIFSFileSystem(new FileInputStream(filePath));
			wb = new HSSFWorkbook(fs);
		} catch (FileNotFoundException e) {
			throw new RuntimeException(e);
		} catch (IOException e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * @author wu_pei
	 */
	class Point {

		/**
		 * @param cellPositionStr
		 *            String
		 */
		public Point(String cellPositionStr) {

			char[] chars = cellPositionStr.toCharArray();
			int i = 0;
			for (; i < chars.length; i++) {
				if (Character.isDigit(chars[i])) {
					break;
				}
			}
			row = Integer.parseInt(cellPositionStr.substring(i));
			col = cellNumStr2Int(cellPositionStr.substring(0, i));
		}

		/**
		 * @param colStr
		 *            String
		 * @param row
		 *            int
		 */
		public Point(String colStr, int row) {

			col = cellNumStr2Int(colStr);
			this.row = row;
		}

		/** */
		int row;

		/** */
		int col;
	}

	/**
	 * Excel中のあるシート中のあるセルに値を代入
	 * 
	 * @param cellPositionStr
	 *            cellPositionStr
	 * @param sheetNo
	 *            sheetNo
	 * @param v
	 *            v
	 * @return HSSFCell
	 */
	public HSSFCell setCellValue(String cellPositionStr, int sheetNo, Object v) {

		Point p = new Point(cellPositionStr);
		return setCellValue(p, sheetNo, v);
	}

	/**
	 * Excel中のあるシート中のあるセルに値を代入
	 * 
	 * @param cellPositionStr
	 *            cellPositionStr
	 * @param v
	 *            v
	 * @return HSSFCell
	 */
	public HSSFCell setCellValue(String cellPositionStr, Object v) {

		Point p = new Point(cellPositionStr);
		return setCellValue(p, 0, v);
	}

	/**
	 * Excel中のあるシート中のあるセルに値を代入
	 * 
	 * @param colNumStr
	 *            String
	 * @param rowNum
	 *            int
	 * @param sheetNo
	 *            int
	 * @param v
	 *            Object
	 * @return HSSFCell
	 */
	public HSSFCell setCellValue(String colNumStr, int rowNum, int sheetNo,
			Object v) {

		Point p = new Point(colNumStr, rowNum);
		return setCellValue(p, sheetNo, v);
	}

	/**
	 * @param p
	 *            Point
	 * @param sheetNo
	 *            int
	 * @param v
	 *            Object
	 * @return HSSFCell
	 */
	public HSSFCell setCellValue(Point p, int sheetNo, Object v) {

		return setCellValue(p.col, p.row, sheetNo, v);
	}

	/**
	 * Excel中のあるシート中のあるセルに値を代入
	 * 
	 * @param colNum
	 *            int
	 * @param rowNum
	 *            int
	 * @param sheetNo
	 *            int
	 * @param v
	 *            Object
	 * @return HSSFCell
	 */
	public HSSFCell setCellValue(int colNum, int rowNum, int sheetNo, Object v) {

		HSSFCell cell = this.getCell(colNum, rowNum, sheetNo);
		if (v == null) {
			cell.setCellValue(new HSSFRichTextString(""));// TODO
			return cell;
		}
		if (v.getClass() == Boolean.class) {
			cell.setCellValue((Boolean) v);
		} else if (v.getClass() == Integer.class) {
			cell.setCellValue((Integer) v);
		} else if (v.getClass() == Double.class) {
			cell.setCellValue((Double) v);
		} else if (v.getClass() == Float.class) {
			cell.setCellValue((Float) v);
		} else if (v.getClass() == BigDecimal.class) {
			cell.setCellValue(((BigDecimal) v).doubleValue());
		} else if (v.getClass() == Date.class) {
			cell.setCellValue(new HSSFRichTextString(FULLTIMEFMT
					.format((Date) v)));// TODO
		} else if (v.getClass() == String.class) {
			cell.setCellValue(new HSSFRichTextString((String) v));
		} else {
			cell.setCellValue(new HSSFRichTextString(v.toString()));
		}

		return cell;
	}

	/**
	 * @param colNumStr
	 *            colNumStr
	 * @param rowNum
	 *            rowNum
	 * @param sheetNo
	 *            sheetNo
	 * @param v
	 *            v
	 * @return HSSFCell
	 */
	public HSSFCell setCellFormula(String colNumStr, int rowNum, int sheetNo,
			Object v) {

		Point p = new Point(colNumStr, rowNum);
		HSSFCell cell = this.getCell(p.col, p.row, sheetNo);

		cell.setCellFormula((String) v);

		return cell;
	}

	/**
	 * 指定行列とシートによってセルを取得
	 * 
	 * @param colNum
	 *            colNum
	 * @param rowNum
	 *            rowNum
	 * @param sheetNo
	 *            sheetNo
	 * @return HSSFCell
	 */
	public HSSFCell getCell(int colNum, int rowNum, int sheetNo) {

		HSSFRow row = getRow(rowNum, sheetNo);
		HSSFCell cell = row.getCell(colNum);
		if (cell == null) {
			cell = row.createCell(colNum);
		}
		return cell;
	}

	/**
	 * @param colNumStr
	 *            colNumStr
	 * @param rowNum
	 *            rowNum
	 * @param sheetNo
	 *            sheetNo
	 * @return HSSFCell
	 */
	public HSSFCell getCell(String colNumStr, int rowNum, int sheetNo) {

		int colNum = cellNumStr2Int(colNumStr);
		return getCell(colNum, rowNum, sheetNo);
	}

	/**
	 * @param cellPositionStr
	 *            cellPositionStr
	 * @param sheetNo
	 *            sheetNo
	 * @return HSSFCell
	 */
	public HSSFCell getCell(String cellPositionStr, int sheetNo) {

		Point p = new Point(cellPositionStr);
		return getCell(p.col, p.row, sheetNo);
	}

	/**
	 * ある行を取得
	 * 
	 * @param rowNum
	 *            rowNum
	 * @param sheetNo
	 *            sheetNo
	 * @return HSSFRow
	 */
	public HSSFRow getRow(int rowNum, int sheetNo) {

		HSSFSheet sheet = wb.getSheetAt(sheetNo);
		HSSFRow row = sheet.getRow(rowNum);
		if (row == null) {
			row = sheet.createRow(rowNum);
		}
		return row;
	}

	/**
	 * 列の名前を数字に変える
	 * 
	 * @param cellNumStr
	 *            cellNumStr
	 * @return cellNum - 1
	 */
	private static int cellNumStr2Int(String cellNumStr) {

		cellNumStr = cellNumStr.toLowerCase();
		int cellNum = 0;
		char[] chars = cellNumStr.toCharArray();
		int j = 0;
		for (int i = chars.length - 1; i >= 0; i--) {
			cellNum += (chars[i] - 'a' + 1) * Math.pow(26, j);
			j++;
		}
		return cellNum - 1;
	}

	/**
	 * excelをある出力ストリームに書き込む
	 * 
	 * @param out
	 *            out
	 */
	public void write(OutputStream out) {

		try {
			wb.write(out);
		} catch (IOException e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * @param filePath
	 *            filePath
	 */
	public void save(String filePath) {

		try {
			OutputStream out = new FileOutputStream(new File(filePath));
			write(out);
			out.flush();
			out.close();
		} catch (FileNotFoundException e) {
			throw new RuntimeException(e.getMessage(), e);
		} catch (IOException e) {
			throw new RuntimeException(e.getMessage(), e);
		}
	}

	/**
	 * あるセルの値を取得、値のタイプを判断
	 * 
	 * @param cell
	 *            cell
	 * @return value
	 */
	private Object getCellValue(HSSFCell cell) {

		Object value = null;
		if (cell != null) {
			int cellType = cell.getCellType();
			HSSFCellStyle style = cell.getCellStyle();
			short format = style.getDataFormat();
			switch (cellType) {
			case HSSFCell.CELL_TYPE_NUMERIC:
				double numTxt = cell.getNumericCellValue();
				System.out.println("Excel.getCellValue()" + cell.getCellNum()
						+ " col format=" + format + " cellType=" + cellType);
				if (format == 22 || format == 14) {
					value = HSSFDateUtil.getJavaDate(numTxt);
				} else {
					value = numTxt;
				}
				break;
			case HSSFCell.CELL_TYPE_BOOLEAN:
				boolean booleanTxt = cell.getBooleanCellValue();
				value = booleanTxt;
				break;
			case HSSFCell.CELL_TYPE_BLANK:
				value = null;
				break;
			case HSSFCell.CELL_TYPE_STRING:
				HSSFRichTextString rtxt = cell.getRichStringCellValue();
				if (rtxt == null) {
					System.out.print("null,");
					break;
				}
				String txt = rtxt.getString();
				value = txt;
				break;
			default:
				System.out.println(cell.getCellNum() + " col cellType="
						+ cellType);
			}
		}
		return value;

	}

	/**
	 * あるexcelを読み取り
	 * 
	 * @param sheetNo
	 *            sheetNo
	 * @return List
	 * @throws Exception
	 *             Exception
	 */
	public List excelToListList(int sheetNo) throws Exception {

		// 先ずはexcelのデータを読み取り、あとは導入されたデータベースの結構とexcelの結構でどんな処理を決定する

		HSSFSheet sheet = wb.getSheetAt(sheetNo);
		int firstRowNum = sheet.getFirstRowNum();
		int lastRowNum = sheet.getLastRowNum();
		List rows = new ArrayList();
		for (int i = firstRowNum; i < lastRowNum; i++) {
			HSSFRow row = sheet.getRow(i);
			List cellList = new ArrayList();
			for (int j = row.getFirstCellNum(); j < row.getLastCellNum(); j++) {
				Object value = null;
				HSSFCell cell = row.getCell((short) j);
				value = getCellValue(cell);

				cellList.add(value);

			}
			rows.add(cellList);
		}
		return rows;
	}

	/**
	 * @param sheetNo
	 *            sheetNo
	 * @return List
	 * @throws Exception
	 *             Exception
	 */
	public List excelToMapList(int sheetNo) throws Exception {

		// 先ずはexcelのデータを読み取り、あとは導入されたデータベースの結構とexcelの結構でどんな処理を決定する

		HSSFSheet sheet = wb.getSheetAt(sheetNo);
		int firstRowNum = sheet.getFirstRowNum();
		int lastRowNum = sheet.getLastRowNum();
		List rows = new ArrayList();
		HSSFRow firstRow = sheet.getRow(firstRowNum);
		for (int i = firstRowNum + 1; i <= lastRowNum; i++) {
			HSSFRow row = sheet.getRow(i);
			if (row == null) {
				continue;
			}
			Map rowMap = new HashMap();
			for (int j = row.getFirstCellNum(); j < row.getLastCellNum(); j++) {
				HSSFCell col = firstRow.getCell((short) j);
				String key = String.valueOf(j + 1);
				Object value = null;
				HSSFCell cell = row.getCell((short) j);
				value = getCellValue(cell);
				rowMap.put(key, value);

			}
			rows.add(rowMap);
		}
		return rows;
	}

	/**
	 * 一行を増加
	 * 
	 * @param targetRowNum
	 *            targetRowNum
	 * @return HSSFRow
	 */
	public HSSFRow createRow(int targetRowNum) {

		HSSFSheet sheet = wb.getSheetAt(0);
		int rowNum = sheet.getLastRowNum();
		HSSFRow targetRow = sheet.getRow(targetRowNum);
		HSSFRow newRow = sheet.createRow(++rowNum);
		newRow.setHeight(targetRow.getHeight());
		int i = 0;
		for (Iterator cit = (Iterator) targetRow.cellIterator(); cit.hasNext();) {
			Cell hssfCell = (Cell) cit.next();
			HSSFCell cell = newRow.createCell((short) i++);
			CellStyle s = hssfCell.getCellStyle();
			cell.setCellStyle(hssfCell.getCellStyle());
		}
		return newRow;
	}

	/**
	 * @param rowNum
	 *            rowNum
	 */
	public void deleteRow(int rowNum) {

		deleteRow(0, rowNum);
	}

	/**
	 * @param sheetNo
	 *            sheetNo
	 * @param rowNum
	 *            rowNum
	 */
	public void deleteRow(int sheetNo, int rowNum) {

		HSSFSheet sheet = wb.getSheetAt(sheetNo);
		sheet.shiftRows(rowNum, sheet.getLastRowNum(), -1);
	}

	/**
	 * 行をコビーして指定の位置に移動する
	 * 
	 * @param sheet
	 *            sheet
	 * @param srcRow
	 *            srcRow
	 * @param targetRowNum
	 *            targetRowNum
	 * @return HSSFRow
	 */
	public HSSFRow copyAndInsertRow(HSSFSheet sheet, HSSFRow srcRow,
			int targetRowNum) {

		int lastRowNum = sheet.getLastRowNum();
		sheet.shiftRows(targetRowNum, lastRowNum, 1);
		HSSFRow newRow = sheet.getRow(targetRowNum);
		newRow.setHeight(srcRow.getHeight());
		int j = 0;
		for (Iterator cit = (Iterator) srcRow.cellIterator(); cit.hasNext();) {
			Cell hssfCell = (Cell) cit.next();
			HSSFCell cell = newRow.createCell(j++);
			cell.setCellStyle(hssfCell.getCellStyle());

			if (hssfCell.getCellType() == HSSFCell.CELL_TYPE_NUMERIC) {
				// cell.setCellValue(hssfCell.getNumericCellValue());
			} else if (hssfCell.getCellType() == HSSFCell.CELL_TYPE_STRING) {
				RichTextString str = hssfCell.getRichStringCellValue();
				if (str.length() > 0) {
					cell.setCellValue(str);
				}
			} else if (hssfCell.getCellType() == HSSFCell.CELL_TYPE_FORMULA) {
				cell.setCellFormula(hssfCell.getCellFormula());
			}

		}
		int mergeedRegions = sheet.getNumMergedRegions();
		for (int i = 0; i < mergeedRegions; i++) {
			Region region = sheet.getMergedRegionAt(i);
			if (region.getRowFrom() == srcRow.getRowNum()
					&& region.getRowTo() == region.getRowFrom()) {
				sheet.addMergedRegion(new Region(targetRowNum, region
						.getColumnFrom(), targetRowNum, region.getColumnTo()));
			}
		}
		return newRow;
	}

	/**
	 * @param sheetNo
	 *            sheetNo
	 * @param fromRowNum
	 *            fromRowNum
	 * @param targetRowNum
	 *            targetRowNum
	 * @return HSSFRow
	 */
	public HSSFRow copyAndInsertRow(int sheetNo, int fromRowNum,
			int targetRowNum) {

		HSSFSheet sheet = wb.getSheetAt(sheetNo);
		HSSFRow srcRow = sheet.getRow(fromRowNum);
		return copyAndInsertRow(sheet, srcRow, targetRowNum);
	}

	/**
	 * @param fromRowNum
	 *            fromRowNum
	 * @param targetRowNum
	 *            targetRowNum
	 * @return HSSFRow
	 */
	public HSSFRow copyAndInsertRow(int fromRowNum, int targetRowNum) {

		return copyAndInsertRow(0, fromRowNum, targetRowNum);
	}

	/**
	 * 一行を増加（フォーマットが最後の一行と一致）
	 * 
	 * @return HSSFRow
	 */
	public HSSFRow copyAndInsertRow() {

		return copyAndInsertRow(1, 2);
	}

	/**
	 * @return wb
	 */
	public HSSFWorkbook getWb() {

		return wb;
	}

	/**
	 * @param wb
	 *            wb
	 */
	public void setWb(HSSFWorkbook wb) {

		this.wb = wb;
	}

	/**
	 * Excel中のあるシートのあるセルに値を代入
	 * 
	 * @param colNum
	 * @param rowNum
	 *            0から
	 * @param sheetNo
	 *            0から
	 * @param v
	 * @return
	 */
	/*
	 * public HSSFCell setCellValue(int colNum, int rowNum, int sheetNo, Object
	 * v){ HSSFCell cell = this.getCell(colNum, rowNum, sheetNo); if(v == null){
	 * cell.setCellValue(new HSSFRichTextString(""));//TODO return
	 * cell.getCellFormula(); } if(v.getClass() == Boolean.class){
	 * cell.setCellValue((Boolean)v); }else if(v.getClass() == Integer.class){
	 * cell.setCellValue((Integer)v); }else if(v.getClass() == Double.class){
	 * cell.setCellValue((Double)v); }else if(v.getClass() == Float.class){
	 * cell.setCellValue((Float)v); }else if(v.getClass() == BigDecimal.class){
	 * cell.setCellValue(((BigDecimal)v).doubleValue()); }else if(v.getClass()
	 * == Date.class){ cell.setCellValue(new
	 * HSSFRichTextString(fullTimeFmt.format((Date)v))); }else if(v.getClass()
	 * == String.class){ cell.setCellValue(new HSSFRichTextString((String)v));
	 * }else{ cell.setCellValue(new HSSFRichTextString(v.toString())); } return
	 * cell; }
	 */

	/**
	 * セルを結合
	 * 
	 * @param rowFrom
	 *            rowFrom
	 * @param columnFrom
	 *            columnFrom
	 * @param rowTo
	 *            rowTo
	 * @param columnTo
	 *            columnTo
	 * @param sheetNo
	 *            sheetNo
	 */
	public void mergeCell(int rowFrom, String columnFrom, int rowTo,
			String columnTo, int sheetNo) {

		HSSFSheet sheet = wb.getSheetAt(sheetNo);
		Region region = new Region((short) rowFrom,
				(short) cellNumStr2Int(columnFrom), (short) rowTo,
				(short) cellNumStr2Int(columnTo));
		sheet.addMergedRegion(region);

	}

	/**
	 * セルのフォーマットをコピー
	 * 
	 * @param rowFrom
	 *            rowFrom
	 * @param columnFrom
	 *            columnFrom
	 * @param rowTo
	 *            rowTo
	 * @param columnTo
	 *            columnTo
	 * @param sheetNo
	 *            sheetNo
	 */
	public void copyCellStyle(int rowFrom, String columnFrom, int rowTo,
			String columnTo, int sheetNo) {

		HSSFSheet sheet = wb.getSheetAt(sheetNo);
		HSSFCell cellFrom = this.getCell(cellNumStr2Int(columnFrom), rowFrom,
				sheetNo);
		int realRow = rowTo - 1;
		HSSFRow row = sheet.getRow(realRow);
		if (row == null) {
			row = sheet.createRow(realRow);
		}
		HSSFCell cellTo = this
				.getCell(cellNumStr2Int(columnTo), rowTo, sheetNo);
		if (cellTo == null) {
			cellTo = row.createCell((short) cellNumStr2Int(columnTo));
		}
		cellTo.setCellStyle(cellFrom.getCellStyle());

	}

	/**
	 * @param fromSheetNo
	 *            fromSheetNo
	 */
	public void copySheet(int fromSheetNo) {

		wb.cloneSheet(fromSheetNo);
	}

	/**
	 * @param sheetNo
	 *            sheetNo
	 * @param sheetName
	 *            sheetName
	 */
	public void setSheetName(int sheetNo, String sheetName) {

		wb.setSheetName(sheetNo, sheetName);
	}

	/**
	 * @param sheetNo
	 *            int
	 * @return sheet.getPhysicalNumberOfRows()
	 */
	public int getRowCount(int sheetNo) {

		HSSFSheet sheet = wb.getSheetAt(sheetNo);
		return sheet.getPhysicalNumberOfRows();
	}

	/**
	 * excel中のシート個数を取得
	 * 
	 * @return count
	 */
	public int getSheets() {

		int count = wb.getNumberOfSheets();
		return count;
	}

	/**
	 * シート名前を取得
	 * 
	 * @param sheetNo
	 *            sheetNo
	 * @return String sheetName
	 */
	public String getSheetName(int sheetNo) {

		String sheetName = wb.getSheetName(sheetNo);
		return sheetName;
	}

	/**
	 * @param sheetNo
	 *            sheetNo
	 * @param rowNo
	 *            rowNo
	 * @return int
	 */
	public int getColCount(int sheetNo, int rowNo) {

		HSSFSheet sheet = wb.getSheetAt(sheetNo);
		return sheet.getRow(rowNo - 1).getPhysicalNumberOfCells();
	}

	/**
	 * シート名前によって総記録数を取得
	 * 
	 * @param sheetName
	 *            sheet名
	 * @return 総記録数（-1の場合、シートが存在しない）
	 */
	public int getRowCount(String sheetName) {

		HSSFSheet sheet = wb.getSheet(sheetName);
		if (sheet != null) {
			return sheet.getPhysicalNumberOfRows();
		} else {
			return -1;
		}
	}

	/**
	 * シート名前、行番号と列番号によってセル値を取得
	 * 
	 * @param sheetName
	 *            sheet名
	 * @param rowNo
	 *            行番号
	 * @param colNo
	 *            列番号
	 * @return セル値
	 */
	public String getCellValue(String sheetName, int rowNo, int colNo) {

		HSSFSheet sheet = wb.getSheet(sheetName);
		if (sheet != null) {
			HSSFRow row = sheet.getRow(rowNo - 1);
			if (row != null) {
				HSSFCell cell = row.getCell(colNo - 1);
				if (cell != null) {
					return cell.toString().trim();
				} else {
					return null;
				}
			} else {
				return null;
			}
		} else {
			return null;
		}
	}

	/**
	 * シート名前、行番号と列番号によってセル値を取得
	 * 
	 * @param sheetName
	 *            sheet名
	 * @param rowNo
	 *            行番号
	 * @param colNo
	 *            列番号
	 * @return セル値
	 */
	public Date getCellDateValue(String sheetName, int rowNo, int colNo) {

		HSSFSheet sheet = wb.getSheet(sheetName);
		if (sheet != null) {
			HSSFRow row = sheet.getRow(rowNo - 1);
			if (row != null) {
				HSSFCell cell = row.getCell(colNo - 1);
				if (cell != null) {
					try {
						return cell.getDateCellValue();
					} catch (Exception ex) {
						return null;
					}
				} else {
					return null;
				}
			} else {
				return null;
			}
		} else {
			return null;
		}
	}

	/**
	 * シート名前、行番号と列番号によってセル値を取得
	 * 
	 * @param sheetName
	 *            sheet名
	 * @param rowNo
	 *            行番号
	 * @param colNo
	 *            列番号
	 * @return セル値
	 */
	public String getCellFormulaValue(String sheetName, int rowNo, int colNo) {

		HSSFSheet sheet = wb.getSheet(sheetName);

		if (sheet != null) {
			HSSFRow row = sheet.getRow(rowNo - 1);
			if (row != null) {
				HSSFCell cell = row.getCell(colNo - 1);
				if (cell != null) {
					try {
						return String.valueOf(cell.getNumericCellValue());
					} catch (Exception ex) {
						return null;
					}
				} else {
					return null;
				}
			} else {
				return null;
			}
		} else {
			return null;
		}
	}
}