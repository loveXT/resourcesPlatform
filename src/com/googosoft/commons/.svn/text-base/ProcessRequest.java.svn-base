package com.googosoft.commons;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.List;
import java.util.ResourceBundle;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.StatusLine;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.BasicResponseHandler;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

public class ProcessRequest {

	private final String waitWork = "http://192.168.0.187/webIm/Process/WaitWork.ashx";
	private final String delWaitWork = "http://192.168.0.187/webIm/Process/DelWaitWork.ashx";
	
	public void doPost(String way,String json) throws ClientProtocolException, IOException{
		DefaultHttpClient httpclient = new DefaultHttpClient();
		List<NameValuePair> nvps = new ArrayList<NameValuePair>();
		HttpPost httpPost = null;
		if("WaitWork".equals(way)){
			httpPost = new HttpPost(waitWork);
			nvps.add(new BasicNameValuePair("action", "WaitWork"));
		}else{
			httpPost = new HttpPost(delWaitWork);
			nvps.add(new BasicNameValuePair("action", "DelWaitWork"));
		}
		nvps.add(new BasicNameValuePair("json", json));
	    httpPost.setEntity(new UrlEncodedFormEntity(nvps));
	    org.apache.http.client.ResponseHandler<String> responseHandler = new BasicResponseHandler();
	    String response2 = httpclient.execute(httpPost,responseHandler);
	    System.out.println("response2====================="+response2);
	    String processStr = new String(response2.getBytes("iso-8859-1"), "utf8");
	    System.out.println("processStr====================="+processStr);
	}
	public List<String> doGet(String userid,String menuid) throws ClientProtocolException, IOException, DocumentException{
		BufferedReader in = null;
		String url = ResourceBundle.getBundle("path").getString("newframekey");
		DefaultHttpClient httpclient = new DefaultHttpClient();
        HttpGet httpGet = new HttpGet(url+"?userid="+userid+"&menuid="+menuid);
        HttpResponse response1 = httpclient.execute(httpGet);
        StatusLine status=response1.getStatusLine();
        try {
        	if(status.getStatusCode()==200){
        		HttpEntity entity1 = response1.getEntity();
        		in = new BufferedReader(new InputStreamReader(entity1.getContent()));
        		SAXReader saxReader = new SAXReader();
     	        Document doc = saxReader.read(in);
     	        System.out.println(doc.asXML());
     	        Element root = doc.getRootElement();
     	        List<Element> elList = root.elements();
     	        StringBuffer sb = new StringBuffer();
    	        List<String> operate_type_list = new ArrayList<String>();
     	        for(Element e:elList){
     	        	operate_type_list.add(e.elementText("opertion_type"));
     	        }
    	        return operate_type_list;
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
