
package jp.mwsoft.sample.twitter4j;

import java.awt.List;
import java.util.ArrayList;
import java.util.regex.Matcher;

import javax.naming.directory.SearchControls;

import org.omg.CORBA.PUBLIC_MEMBER;

import twitter4j.Status;
import twitter4j.TwitterException;

public class Sub_mining extends Mining {
	protected ArrayList<String> tweet_reply_id = new ArrayList<String>();
	
	public void sub_search(String newSearch_word) throws TwitterException,
			InterruptedException {
		super.search(search_word);
		super.getTweet_list();
		//System.out.println(tweet_list);
		for (int t = 0; t < tweet_list.size(); t++) {
			String tweet_list_parse = tweet_list.get(t);
			String[] tweet_array = tweet_list_parse.split(" ");
			//@‚©‚çŽŸ‚Ì•¶Žš—ñ‚ðŽæ‚èo‚µ‚Ä‚é
			int index = tweet_array[0].indexOf("@");
			tweet_reply_id.add(tweet_array[0].substring(index+1));
		}
		for (int id = 0; id< tweet_reply_id.size(); id++ ){;
			String reply_id = tweet_reply_id.get(id);
		}
	}
	public ArrayList<String> getsub_search(){
		return tweet_reply_id;
	}
	
}

