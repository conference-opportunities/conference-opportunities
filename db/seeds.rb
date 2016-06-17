# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

conference1 = Conference.new(
  twitter_handle: "femcultureconf",
  logo_url: "http://www.btvsonline.com/wp-content/uploads/2012/05/buffy-prophecy-girl.jpg",
  name: "Feminism and Pop Culture Conference",
  location: "San Jose, Puerto Rico",
  website_url: "http://feminsimpopcultureconf.org",
  description: "Dissecting pop culture from 1950 to today through a feminist lens.",
  approved_at: Time.now,
  cfp_deadline: Time.now + 6.months,
  cfp_url: "http://feminsimpopcultureconf.org/cfp",
  has_travel_funding: false,
  has_lodging_funding: false,
  has_honorariums: false,
  has_diversity_scholarships: false,
  uid: "seeduid3",
  starts_at: Time.now + 10.months,
  ends_at: Time.now + 10.months + 3.days,
  attendee_count: 1200,
  cfp_count: 50,
  keynote_count: 2,
  other_count: "",
  panel_count: 4,
  plenary_count: "",
  prior_submissions_count: 230,
  talk_count: 40,
  track_count: 2,
  tutorial_count: 3,
  workshop_count: 1
)

conference2 = Conference.new(
  twitter_handle: "wdwscc",
  logo_url: "https://893165d5b5ae626053ff-9a10668358e268b3bfc22996e60ffcf4.ssl.cf3.rackcdn.com/2014/10/MM-9536.jpg",
  name: "Women's Deep Water Solo Climbing Conf",
  location: "Tonsai, Thailand",
  website_url: "http://wdwscc.org",
  description: "Learn techniques for deep water solo climbing and put those techniques into practice.",
  approved_at: Time.now,
  cfp_deadline: Time.now + 10.months,
  cfp_url: "http://wdwscc.org/cfp",
  has_travel_funding: true,
  has_lodging_funding: true,
  has_honorariums: false,
  has_diversity_scholarships: false,
  uid: "seeduid1",
  starts_at: Time.now + 12.months,
  ends_at: Time.now + 12.months + 5.days,
  attendee_count: 500,
  cfp_count: 20,
  keynote_count: 1,
  other_count: "",
  panel_count: 6,
  plenary_count: "",
  prior_submissions_count: 175,
  talk_count: 10,
  track_count: 1,
  tutorial_count: 1,
  workshop_count: 6
)

conference3 = Conference.new(
  twitter_handle: "beerandchocolate",
  logo_url: "http://www.newschoolbeer.com/wp-content/uploads/2015/05/indulgence-chocolatiers.jpg",
  name: "Beer and Chocolate Conf 2017",
  location: "Madison, WI",
  website_url: "http://beerchococonf.org",
  description: "We drink beer and eat chocolate.",
  approved_at: Time.now,
  cfp_deadline: Time.now + 3.months,
  cfp_url: "http://beerchoco.org/cfp",
  has_travel_funding: true,
  has_lodging_funding: false,
  has_honorariums: true,
  has_diversity_scholarships: false,
  uid: "seeduid2",
  starts_at: Time.now + 6.months,
  ends_at: Time.now + 6.months + 3.days,
  attendee_count: 750,
  cfp_count: 60,
  keynote_count: 8,
  other_count: "",
  panel_count: 10,
  plenary_count: "",
  prior_submissions_count: 724,
  talk_count: 50,
  track_count: 3,
  tutorial_count: 1,
  workshop_count: 4
)

organizer2 = Organizer.new(
  provider: "seedprovider1",
  locale: "Tonsai, Thailand",
  uid: "seeduid1"
)

organizer3 = Organizer.new(
  provider: "seedprovider2",
  locale: "Madison, WI",
  uid: "seeduid2"
)

organizer1 = Organizer.new(
  provider: "seedprovider3",
  locale: "New York, NY",
  uid: "seeduid3"
)

organizer1.conference = conference1
organizer1.save

organizer2.conference = conference2
organizer2.save

organizer3.conference = conference3
organizer3.save
