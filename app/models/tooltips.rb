class Tooltips 
	def initialize(args)
		
	end

	#messages
	money = "<A HREF=\"http://www.ashedryden.com/blog/help-more-people-attend-your-conference\">Help People Afford to Attend Your Conference</a> by Ashe Dryden"
	who_pays_upfront = ""
	beginner_friendly = ""
	welcoming_general = ""
	inclusion_effort = "Women Don't Ask."
	access_general = ""
	accomodations_food = ""
	accomodations_physical_disability = ""
	accomodations_invisible_illness = ""
	accomodations_religious = ""
	childcare = ""
	pumproom = ""
	quiet_room = ""
	proposal_anonymization = ""
	proposal_section_method = ""
	diversity_scholarships = ""

	#message groupings
	economic = [money,who_pays_upfront]
	geographic = []
	parenting = [childcare,pumproom]
	accessibility = [beginner_friendly,welcoming_general,access_general,accomodations_food,accomodations_invisible_illness,accomodations_physical_disability,accomodations_religious,quiet_room]
	inclusion_speakers = [inclusion_effort,proposal_anonymization,proposal_section_method]
	inclusion_attendees [diversity_scholarships]
	welcoming_environment = [welcoming_general,beginner_friendly]

	#Places to show messages
	nominate_speakers = [inclusion_speakers]
	code_of_conduct = [welcoming_environment]
	incentive_proposing_discount = [economic]
	incentive_proposing_ticket_set_aside_preferred_price = [economic]
	incentive_proposing_public_info_sessions = [economic]
	incentive_proposing_feedback = [welcoming_environment]
	incentive_speaking_free_ticket = [economic]
	incentive_speaking_honorarium = [economic]
	incentive_speaking_expenses_covered = [economic]
	affordability_who_pays_upfront = [economic]
	travel_sponsorship = [economic]
	proposal_process = [inclusion_speakers]

end