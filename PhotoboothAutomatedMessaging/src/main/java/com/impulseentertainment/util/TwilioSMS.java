package com.impulseentertainment.util;

import com.twilio.Twilio;
import com.twilio.rest.api.v2010.account.Message;
import com.twilio.type.PhoneNumber;

public class TwilioSMS {

	public static final String ACCOUNT_SID = "AC4f618bdbcd3a59be4977796ef34205fa";
	public static final String AUTH_TOKEN = "3d75d0537c7ec16f83346f1c2cefe30b";

	public static void sendSMS(String phoneNumber, String textMessage) {
		Twilio.init(ACCOUNT_SID, AUTH_TOKEN);

		Message message = Message.creator(new PhoneNumber(phoneNumber), new PhoneNumber("+17082865696"), textMessage)
				.create();

		System.out.println(message.getSid());
	}

}
