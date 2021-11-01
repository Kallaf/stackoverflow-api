namespace :update_cache do
  desc "update trending questions cache"
  task trending_questions: :environment do
    print "updating trend\n"
    trend = Question.update_trend
    puts Question.get_trend_from_cache
  end

end
