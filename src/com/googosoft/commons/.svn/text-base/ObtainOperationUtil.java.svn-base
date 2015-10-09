package com.googosoft.commons;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.List;
import java.util.ResourceBundle;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.StatusLine;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;


public class ObtainOperationUtil {
	
	public static String getOpreations(String menuid,String userId) throws ClientProtocolException, IOException, DocumentException{
		BufferedReader in = null;
		String url = ResourceBundle.getBundle("path").getString("newframekey");
		DefaultHttpClient httpclient = new DefaultHttpClient();
        HttpGet httpGet = new HttpGet(url+"?userid="+userId+"&menuid="+menuid);
        HttpResponse response1 = httpclient.execute(httpGet);
        StatusLine status=response1.getStatusLine();
        try {
           if(status.getStatusCode()==200){
        	   HttpEntity entity1 = response1.getEntity();
        	   in = new BufferedReader(new InputStreamReader(entity1.getContent(),"utf-8"));
        		SAXReader saxReader = new SAXReader();
     	        Document doc = saxReader.read(in);
     	        Element root = doc.getRootElement();
     	        List<Element> elList = root.elements();
     	        StringBuffer sb = new StringBuffer();
     	        for(Element e:elList){
     	        	sb.append(e.elementText("opertion_type"));
     	        	sb.append(",");
     	        }
     	        return sb.toString();
           }
           
        } finally {
            httpGet.releaseConnection();
            if (in != null) {  
                try {  
                 in.close();// 最后要关闭BufferedReader  
             } catch (Exception e) {  
                   e.printStackTrace();  
              }  
        }  
        }
	        return null;
		
	}
}
