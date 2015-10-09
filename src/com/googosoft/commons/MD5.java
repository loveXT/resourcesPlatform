package com.googosoft.commons;

import java.security.MessageDigest;

public class MD5
{
//  private static String MD5 = "md5";

  public static String getPassword(String str)
  {
    try
    {
      MessageDigest md = MessageDigest.getInstance("MD5");
      str = str == null ? "" : str;
//      str = str + MD5;
      md.update(str.getBytes());
      byte[] b = md.digest();

      StringBuffer buf = new StringBuffer();
      for (int offset = 0; offset < b.length; offset++) {
        int i = b[offset];
        if (i < 0)
          i += 256;
        if (i < 16)
          buf.append("0");
        buf.append(Integer.toHexString(i));
      }
      str = buf.toString();
    } catch (Exception e) {
      e.printStackTrace();
    }

    return str.toUpperCase();
  }

  public static String addPassword(String str) {
    if (Validate.isNull(str)) {
      return null;
    }
    StringBuffer sb = new StringBuffer();
    for (int i = 0; i < str.length(); i++) {
      sb.append((char)(str.charAt(i) + '\003'));
    }
    String m = sb.toString();
    return m.replace("=", "!");
  }

  public static String backPassword(String str) {
    if (Validate.isNull(str)) {
      return null;
    }
    str = str.replace("!", "=");
    StringBuffer sb = new StringBuffer();
    for (int i = 0; i < str.length(); i++) {
      sb.append((char)(str.charAt(i) - '\003'));
    }
    return sb.toString();
  }
}