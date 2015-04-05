package jp.mwsoft.sample.twitter4j;

import java.util.ArrayList;

import twitter4j.Query;
import twitter4j.QueryResult;
import twitter4j.Status;
import twitter4j.Tweet;
import twitter4j.Twitter;
import twitter4j.TwitterException;
import twitter4j.TwitterFactory;

public class Simple_search {
	protected static String simple_search_word;
	protected ArrayList<String> simple_tweet_list = new ArrayList<String>();
	
	public ArrayList<String> getSimple_tweet_list() {
		return simple_tweet_list;
	}

	protected void setSimple_tweet_list(ArrayList<String> simple_tweet_list) {
		this.simple_tweet_list = simple_tweet_list;
	}
	protected String getSimple_Search_word() {
		return simple_search_word;
	}

	protected void setSimple_Search_word(String simple_search_word) {
		this.simple_search_word = simple_search_word;
	}
	
	public void simple_search(String simple_search_word) throws TwitterException,
	InterruptedException {
		// 初期化
		Twitter twitter = new TwitterFactory().getInstance();
		Query query = new Query();
		// 検索ワードをセット
		
		query.setQuery(simple_search_word);
		// 1度のリクエストで取得するTweetの数（100が最大）
		query.setLang("ja");
		query.setCount(10);
		// 最大1500件（15ページ）なので15回ループ
		for (int i = 1; i <= 15; i++) {
			// ページ指定
			// query.setPage(i);
			// 検索実行
			QueryResult result = twitter.search(query);
			// 取ったテキストを表示
			for (Status tweet : result.getTweets()) {
				//System.out.println(tweet.getUser().getScreenName());
				simple_tweet_list.add(tweet.getText());
		//		System.out.println(tweet.getText());
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

