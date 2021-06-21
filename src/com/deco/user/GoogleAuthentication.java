package com.deco.user;
import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class GoogleAuthentication extends Authenticator {
	PasswordAuthentication passAuth;
    
    public GoogleAuthentication(){
        passAuth = new PasswordAuthentication("decoauth", "stzzltrrrbhjnqxh");
    }
 
    public PasswordAuthentication getPasswordAuthentication() {
        return passAuth;
    }
}

