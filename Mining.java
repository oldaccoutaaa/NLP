package jp.mwsoft.sample.twitter4j;

import java.awt.List;
import java.util.ArrayList;
import java.util.StringTokenizer;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.omg.CORBA.PUBLIC_MEMBER;

import twitter4j.Query;
import twitter4j.QueryResult;
import twitter4j.Status;
import twitter4j.Status;
import twitter4j.Tweet;
import twitter4j.Twitter;
import twitter4j.TwitterException;
import twitter4j.TwitterFactory;
import twitter4j.User;

public class Mining {

//	private ArrayList<String> add_tweet_list = new ArrayList<String>();
	protected ArrayList<String> tweet_list = new ArrayList<String>();
	protected ArrayList<String> tweet_username = new ArrayList<String>();
	protected ArrayList<String> tweet_list_String = new ArrayList<String>();
	protected static String search_word;

	protected void Createlist() {
		tweet_list = new ArrayList<String>();
	}

	protected String getSearch_word() {
		return search_word;
	}
	
	protected void setSearch_word(String search_word) {
		this.search_word = search_word;
	}

	protected void setTweet_list(ArrayList<String> tweet_list) {
		this.tweet_list = tweet_list;
	}


	public ArrayList<String> getTweet_list() {
		return tweet_list;
	}

	
	public void search(String search_word) throws TwitterException,
			InterruptedException {

		Twitter twitter = new TwitterFactory().getInstance();
		Query query = new Query();

		query.setQuery(search_word);
		query.setLang("ja");
	
		query.setCount(10);
		for (int i = 1; i <= 15; i++) {

			System.out.println("ページ数 : " + new Integer(i).toString());
			QueryResult result = twitter.search(query);

			for (Status tweet : result.getTweets()) {

				// 本文
				String str = tweet.getText();

				Pattern p = Pattern.compile(search_word);
				Matcher m = p.matcher(str);

				// StringTokenizer st = new StringTokenizer(tweet.getText());
				if (m.find()) {
					//String screenName = twitter.getScreenName();
					// System.out.println(screenName);
				    //System.out.println(tweet.getUser().getScreenName());
					tweet_username.add(tweet.getUser().getScreenName());
					tweet_list.add(tweet.getText());
				}
			}
			System.out.println(result.getTweets().size());
			// たまに次ページあるのに100件取れないことがあるから
			// 95件以上あったら次ページを確認しに行くことにする
			if (result.getTweets().size() < 95)
				break;
			// 連続でリクエストすると怒られるので3秒起きにしておく
			Thread.sleep(3000);
		}
	}
}

