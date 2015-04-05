package jp.mwsoft.sample.twitter4j;

import igo.Igo_create;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.StringTokenizer;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.naming.directory.SearchControls;
import javax.xml.soap.Text;

import twitter4j.Query;
import twitter4j.QueryResult;
import twitter4j.Status;
import twitter4j.Status;
import twitter4j.Tweet;
import twitter4j.Twitter;
import twitter4j.TwitterException;
import twitter4j.TwitterFactory;

public class Twitter_search {
	public static void main(String[] args) throws TwitterException,
			InterruptedException, FileNotFoundException, IOException {
		// èâä˙âª
		HashMap<String, String> map = new HashMap<String, String>();
		Mining mining_main = new Mining();
		Sub_mining n = new Sub_mining();
		Create_arrray cre = new Create_arrray();
		Igo_create igo = new Igo_create();

		mining_main.search("@.*" + " " + "Ç†");
		mining_main.setSearch_word("@.*" + " " + "Ç†");
		
		System.out.println(mining_main.getTweet_list());
		n.sub_search("");
		n.getsub_search();

		cre.create_array(n.getsub_search(), mining_main.tweet_username);
		System.out.println(cre.getAdd_create_array());

		for (int nu = 0; nu < mining_main.getTweet_list().size(); nu++) {
			map.put(mining_main.getTweet_list().get(nu), cre
					.getAdd_create_array().get(nu));
		}
		for (String str : map.keySet()) {
			System.out.println(str + ":" + map.get(str));
			if(map.get(str)!= ""){
			igo.igo(str);
			igo.igo(map.get(str));
			}
		}
	}

}
