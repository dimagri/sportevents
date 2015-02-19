namespace :mailing do
	task :send_news_feed => :environment do
		User.all.each do |user|
			if user.email.present?
				unread_events = get_unread_events(user)
				# events_to_show = unread_events.not_started
				UserMailer.news_feed(user.email, unread_events).deliver if unread_events.any?
				unread_events.map { |e| e.mark_as_read!(for: user) }
			end
		end	
	end

	

	def get_unread_events(user)
		unread_events = []
		user.friends.each do |friend|
			unread_events += friend.events.not_started.unread_by(user)
		end
		unread_events
	end
end