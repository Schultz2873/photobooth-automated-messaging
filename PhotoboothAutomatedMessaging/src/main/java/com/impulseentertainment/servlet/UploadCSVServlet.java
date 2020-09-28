package com.impulseentertainment.servlet;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.apache.poi.EncryptedDocumentException;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;

import com.impulseentertainment.util.SendGridEmail;
import com.impulseentertainment.util.TwilioSMS;
import com.opencsv.CSVReader;
import com.twilio.Twilio;
import com.twilio.rest.api.v2010.account.Message;
import com.twilio.type.PhoneNumber;

@WebServlet("/UploadServlet")
@MultipartConfig
public class UploadCSVServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public UploadCSVServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Part filePart = request.getPart("csvFile");
		String clientName = (String) request.getAttribute("clientName");
		InputStream fileContent = null;
		String message = "Hello! It was great seeing you at ";

		if (filePart != null) {
			System.out.println("Not null");
			fileContent = filePart.getInputStream();
		} else {
			System.out.println("It's null");
		}

		CSVReader reader = null;

		try {

			reader = new CSVReader(new InputStreamReader(fileContent));

			String[] line;
			ArrayList<String> phoneNumbers = new ArrayList<>();
			ArrayList<String> emails = new ArrayList<>();

			reader.readNext();
			while ((line = reader.readNext()) != null) {
				String currentEmail = line[1];
				String currentPhoneNumber = line[2];

				if (currentEmail.equals("")) {
					phoneNumbers.add(currentPhoneNumber);
				} else if (currentPhoneNumber.equals("")) {
					emails.add(currentEmail);

				}

			}

			System.out.println(phoneNumbers.toString());
			System.out.println(emails.toString());

			phoneNumbers = removeDuplicates(phoneNumbers);
			emails = removeDuplicates(emails);

			System.out.println(phoneNumbers.toString());
			System.out.println(emails.toString());

			request.setAttribute("alert", "Works well");

			request.getRequestDispatcher("index.jsp").forward(request, response);

		} catch (Exception e) {
			System.out.println(e);
		}

//		TwilioSMS.sendSMS("+17083372035", message);
//		SendGridEmail.sendEmail("steveschultz73@gmail.com");

	}

	/**
	 * Removes duplicate String values in an ArrayList
	 * 
	 * @param list - an ArrayList containing String values
	 * @return - An ArrayList of duplicate values removed
	 */
	private ArrayList<String> removeDuplicates(ArrayList<String> list) {
		ArrayList<String> newList = new ArrayList<>();

		for (String element : list) {
			if (!newList.contains(element)) {
				newList.add(element);
			}
		}

		return newList;

	}

}
