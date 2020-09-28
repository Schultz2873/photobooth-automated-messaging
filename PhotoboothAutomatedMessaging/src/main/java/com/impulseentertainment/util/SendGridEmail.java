package com.impulseentertainment.util;

import com.sendgrid.*;
import com.sendgrid.helpers.mail.Mail;
import com.sendgrid.helpers.mail.objects.*;

import java.io.IOException;

public class SendGridEmail {
	public static final String SENDGRID_API_KEY = "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";

	public static void sendEmail(String email) throws IOException {
		Email from = new Email("steveschultz73@gmail.com");
		Email to = new Email(email); // use your own email address here

		String subject = "Testing";
		Content content = new Content("text/plain",
				"Here is a test email. I can probaby separate stuff into paragraphs but not sure how to do that right now.");

		Mail mail = new Mail(from, subject, to, content);

		SendGrid sg = new SendGrid(SENDGRID_API_KEY);
		Request request = new Request();

		request.setMethod(Method.POST);
		request.setEndpoint("mail/send");
		request.setBody(mail.build());

		Response response = sg.api(request);

		System.out.println(response.getStatusCode());
		System.out.println(response.getHeaders());
		System.out.println(response.getBody());
	}

}
