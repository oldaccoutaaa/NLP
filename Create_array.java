package jp.mwsoft.sample.twitter4j;

import twitter4j.TwitterException;
import twitter4j.examples.oauth.GetAccessToken;

import java.util.ArrayList;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.omg.CORBA.PUBLIC_MEMBER;

class Create_arrray {
	protected ArrayList<String> add_create_array = new ArrayList<String>();

	public ArrayList<String> getAdd_create_array() {
		return add_create_array;
	}

	public void setAdd_create_array(ArrayList<String> add_create_array) {
		this.add_create_array = add_create_array;
	}

	public void create_array(ArrayList<String> tweet_reply_id,
			ArrayList<String> tweet_username) throws TwitterException,
			InterruptedException {

		Simple_search simple_mining = new Simple_search();

		// System.out.ln(tweet_reply_id);
		for (int id = 0; id < tweet_reply_id.size(); id++) {
			System.out.println("start");

			String username_string = tweet_username.get(id);
			// System.out.println(username_string);
			// System.out.println("from:"+tweet_reply_id.get(id) + " "+
			// username_string);
			simple_mining.simple_search("from:" + tweet_reply_id.get(id) + " "
					+ username_string);
			System.out.println("!!!!!!!!!!");
			try {
				System.out.println(simple_mining.getSimple_tweet_list().get(0));
				add_create_array.add(simple_mining.getSimple_tweet_list()
						.get(0));
				simple_mining.getSimple_tweet_list().clear();
				// throw new java.lang.ArrayIndexOutOfBoundsException();
			} catch (java.lang.IndexOutOfBoundsException e) {
				add_create_array.add("");
				System.out.println("error");
			}

		}

	}

}
