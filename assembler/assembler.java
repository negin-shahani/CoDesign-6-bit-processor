package codesignFinal;

import java.util.ArrayList;
import java.util.Scanner;

public class assembler {

	public static void main(String[] args) {

		Scanner input = new Scanner(System.in);
		ArrayList<String> content = new ArrayList<>();
		String opCode = "", Rx = "", Ry = "";
		String[] instruction;

		// get the lines of code
		System.out.println("enter the number of lines in your assembelly code : ");
		int n = Integer.parseInt(input.nextLine());

		// get the assembly code in console and add it to arraylist
		for (int i = 0; i < n; i++) {
			content.add(input.nextLine());
		}
		input.close();
		for (int i = 0; i < content.size(); i++) {
			instruction = content.get(i).split(" ");
			switch (instruction[0]) {
			case "LOAD": { 									//if the operation is LOAD
				opCode = "00";
				switch (instruction[1]) {				//try to find the destination register
				case "R0,":
					Rx = "00";
					break;
				case "R1,":
					Rx = "01";
					break;
				case "R2,":
					Rx = "10";
					break;
				case "R3,":
					Rx = "11";
					break;
				default:
					break;
				}
				System.out.println(opCode + Rx + "00");
				String value = "000000" + (Integer.toBinaryString(Integer.parseInt(instruction[2])));
				System.out.println(value.substring(value.length() - 6, value.length())); //store the value from LOAD part in next line
				break;
			}
			case "ADD":										//if the operation is ADD
				opCode = "01";
				switch (instruction[1]) {				//try to find the first inc reg and destination register
				case "R0,":
					Rx = "00";
					break;
				case "R1,":
					Rx = "01";
					break;
				case "R2,":
					Rx = "10";
					break;
				case "R3,":
					Rx = "11";
					break;
				default:
					break;
				}
				switch (instruction[2]) {			//try to find the second inc register
				case "R0":
					Ry = "00";
					break;
				case "R1":
					Ry = "01";
					break;
				case "R2":
					Ry = "10";
					break;
				case "R3":
					Ry = "11";
					break;
				default:
					Ry = "00";
					break;
				}
				System.out.println(opCode + Rx + Ry);
				break;

			case "SUB":											//if the operation is SUB
				opCode = "10";
				switch (instruction[1]) {					//try to find the first inc reg and destination register
				case "R0,":
					Rx = "00";
					break;
				case "R1,":
					Rx = "01";
					break;
				case "R2,":
					Rx = "10";
					break;
				case "R3,":
					Rx = "11";
					break;
				default:
					break;
				}
				switch (instruction[2]) {				//try to find the second inc register
				case "R0":
					Ry = "00";
					break;
				case "R1":
					Ry = "01";
					break;
				case "R2":
					Ry = "10";
					break;
				case "R3":
					Ry = "11";
					break;
				default:
					Ry = "00";
					break;
				}
				System.out.println(opCode + Rx + Ry);
				break;

			case "JNZ": {											//if the operation is JNZ
				opCode = "11";
				switch (instruction[1]) {				//try to find the register of condition
				case "R0,":
					Rx = "00";
					break;
				case "R1,":
					Rx = "01";
					break;
				case "R2,":
					Rx = "10";
					break;
				case "R3,":
					Rx = "11";
					break;
				default:
					break;
				}
				System.out.println(opCode + Rx + "00");
				String value = "000000" + (Integer.toBinaryString(Integer.parseInt(instruction[2])));
				System.out.println(value.substring(value.length() - 6, value.length()));
				break;
			}
			case "HLT":
                System.out.println("111111");
			default:
				break;
			}
		}
	}
}
