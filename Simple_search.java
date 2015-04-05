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
		// ������
		Twitter twitter = new TwitterFactory().getInstance();
		Query query = new Query();
		// �������[�h���Z�b�g
		
		query.setQuery(simple_search_word);
		// 1�x�̃��N�G�X�g�Ŏ擾����Tweet�̐��i100���ő�j
		query.setLang("ja");
		query.setCount(10);
		// �ő�1500���i15�y�[�W�j�Ȃ̂�15�񃋁[�v
		for (int i = 1; i <= 15; i++) {
			// �y�[�W�w��
			// query.setPage(i);
			// �������s
			QueryResult result = twitter.search(query);
			// ������e�L�X�g��\��
			for (Status tweet : result.getTweets()) {
				//System.out.println(tweet.getUser().getScreenName());
				simple_tweet_list.add(tweet.getText());
		//		System.out.println(tweet.getText());
			}
			System.out.println(result.getTweets().size());
			// ���܂Ɏ��y�[�W����̂�100�����Ȃ����Ƃ����邩��
			// 95���ȏ゠�����玟�y�[�W���m�F���ɍs�����Ƃɂ���
			if (result.getTweets().size() < 95)
				break;
			// �A���Ń��N�G�X�g����Ɠ{����̂�3�b�N���ɂ��Ă���
			Thread.sleep(3000);
		}
	}

	
}

