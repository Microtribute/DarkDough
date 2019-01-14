class Question < ActiveRecord::Base
	ANSWER_TYPE = {
		:_agreement=>{
			:id => "_agreement",
			:name=> "Agreement",
			:type=> "radio",
			:answers =>[
				{:id=>'_SD', :sentence=>"Strongly disagree", :class=>"strongly_disagree", :score=>-2},
				{:id=>'_MD', :sentence=>"Moderately disagree", :class=>"moderately_disagree", :score=>-1},
				{:id=>'_AD', :sentence=>"Neither agree nor disagree", :class=>"agree_nor_disagree", :score=>0},
				{:id=>'_MA', :sentence=>"Moderately agree", :class=>"moderately_agree", :score=>1},
				{:id=>'_SA', :sentence=>"Strongly agree", :class=>"strongly_agree", :score=>2}
			]
		},
		:_prefer_1=>{
			:id => "_prefer_1",
			:name=> "Prefer 1",
			:type=> "radio",
			:answers =>[
				{:id=>'_PRF1', :sentence=>"<span></span>Spend more on lifestyle now and have less savings in retirement", :score=>-2, :class=>'grey-btn large ok'},
				{:id=>'_PRF2', :sentence=>"Spend less on lifestyle now and have more savings in retirement", :score=>2, :class=>'grey-btn large ok'}
			]
		},
		:_prefer_2=>{
			:id => "_prefer_2",
			:name=> "Prefer 2",
			:type=> "radio",
			:answers =>[
				{:id=>'_PRF1', :sentence=>"<span></span>Need or would like additional income", :score=>2, :class=>'grey-btn large ok'},
				{:id=>'_PRF2', :sentence=>"<span></span>Have sufficient assets", :score=>-2, :class=>'grey-btn large ok'}
			]
		},
		:_prefer_3=>{
			:id => "_prefer_3",
			:name=> "Prefer 3",
			:type=> "radio_with_multivalue",
			:answers =>[
				{:id=>'_legacy', :sentence=>"<span></span>Legacy", :score=>[2,-2], :class=>'bgdotted ok'},
				{:id=>'_lifestyle', :sentence=>"<span></span>Lifestyle", :score=>[-2,2], :class=>'bgdotted ok'},
				{:id=>'_thrift', :sentence=>"<span></span>Thrift", :score=>[0,0], :class=>'bgdotted ok'}
			]
		},
		:_yesno=>{
			:id => "_yesno",
			:name=> "Yes or No",
			:type=> "radio",
			:answers =>[
				{:id=>'_yes', :sentence=>"<span></span>Yes", :score=>-2, :class=>'grey-btn ok'},
				{:id=>'_no', :sentence=>"<span></span>No", :score=>2, :class=>'grey-btn'}
			]
		},
		:_table=>{
			:id => "_table",
			:name=> "Table",
			:type=> "table",
			:answers =>[
				{:id=>'_q1', 	:sentence=>"The currency change during the civil war", :class=>'label'},
				{:id=>'_q2', 	:sentence=>"The currency devaluation during the Structural Adjustment Programme (SAP) era", :class=>'label'},
				{:id=>'_q3', 	:sentence=>"The Finance House Ponzi schemes of the 1990s", :class=>'label'},
				{:id=>'_q4', 	:sentence=>"The failed banks debacle of the 1990s", :class=>'label'},
				{:id=>'_q5', 	:sentence=>"The wonder bank saga of the 2000s", :class=>'label'},
				{:id=>'_q6', 	:sentence=>"The stock market crash of 2008", :class=>'label'},
				{:id=>'_q7', 	:sentence=>"Unemployment", :class=>'label'},
				{:id=>'_q8', 	:sentence=>"Business failure", :class=>'label'},
				{:id=>'_q9', 	:sentence=>"Childhood poverty", :class=>'label'},
				{:id=>'_q10',	:sentence=>"Refugee statuss", :class=>'label'},
				{:id=>'_q11',	:sentence=>"Divorce", :class=>'label'},
				{:id=>'_q12',	:sentence=>"Accident, illness or death", :class=>'label'},
				{:id=>'_q13',	:sentence=>"Addictions", :class=>'label'},
				{:id=>'_q14',	:sentence=>"Natural disaster", :class=>'label'}
			],
			:scores=>[
				{:id => 'me', :sentence=>"Me", :score=>1 },
				{:id => 'parents', :sentence=>"Parents", :score=>0.5 },
				{:id => 'neither', :sentence=>"Neither", :score=>-2 },
				{:id => 'both', :sentence=>"Both", :score=>2 }
			]
		},
		:_good=>{
			:id => "_good",
			:name=> "Good",
			:type=> "radio",
			:answers =>[
				{:id=>'_extremely', :sentence=>"Extremely", :score=>2, :class=>"strongly_disagree"},
				{:id=>'_very', :sentence=>"Very", :score=>1, :class=>"moderately_disagree"},
				{:id=>'_moderately', :sentence=>"Moderately", :score=>0, :class=>"agree_nor_disagree"},
				{:id=>'_mildly', :sentence=>"Mildly", :score=>-1, :class=>"moderately_agree"},
				{:id=>'_notatall', :sentence=>"Not at all", :score=>-2, :class=>"strongly_agree"}
			]
		},
		:_habbit=>{
			:id => "_habbit",
			:name=> "Habbit",
			:type=> "check",
			:answers =>[
				{:id=>'_recreation', :sentence=>"Recreation", :class=>'switch'},
				{:id=>'_travel', :sentence=>"Travel", :class=>'switch'},
				{:id=>'_education', :sentence=>"Education", :class=>'switch'},
				{:id=>'_family', :sentence=>"Family", :class=>'switch'},
				{:id=>'_spirit', :sentence=>"Spirituality/Religion", :class=>'switch'},
				{:id=>'_financial', :sentence=>"Financial", :class=>'switch'}
			],
			:scores => [
				{:id=>'_none', :limit=>0, :compare_type=>'eq', :score=>-2},
				{:id=>'_one', :limit=>1, :compare_type=>'eq', :score=>-1},
				{:id=>'_two', :limit=>2, :compare_type=>'eq', :score=>1},
				{:id=>'_three', :limit=>3, :compare_type=>'gt', :score=>2}
			]
		},
		:_multiline_text=>{
			:id => "_multiline_text",
			:name=> "Multi-line text",
			:type=> "multiline_text",
			:scores => [
				{:id=>'_none', :limit=>0, :compare_type=>'eq', :score=>-2},
				{:id=>'_one', :limit=>1, :compare_type=>'eq', :score=>-1},
				{:id=>'_two', :limit=>2, :compare_type=>'eq', :score=>1},
				{:id=>'_three', :limit=>3, :compare_type=>'gt', :score=>2}
			],
			:answers =>[]
		}
	}
	
	HARDFACTS_TYPE = {
		:_normal => {
			:presence => false,
			:data_type => "currency"
		},
		:_presence=>{
			:presence => true,
			:data_type => "currency"
		}
	}
	
	HARDFACTS = {
		:_prefix => "_h",
		:_assets=> {
			:_cash =>{:id => "_cash", 		:sentence => "Cash", :type=>'_presence' },
			:_pension =>{:id => "_pension", 	:sentence => "Pension account balance", :type=>'_normal' },
			:_current =>{:id => "_current", 	:sentence => "Current & Savings account balances", :type=>'_presence' },
			:_market =>{:id => "_market",		:sentence => "Market value of primary residence (if you own the  property)", :type=>'_normal' },
			:_fixed_deposit =>{:id => "_fixed_deposit", :sentence => "Fixed deposits", :type=>'_presence' },
			:_automobiles =>{:id => "_automobiles", :sentence => "Automobiles", :type=>'_normal' },
			:_cash_surrender =>{:id => "_cash_surrender", :sentence => "Cash surrender value of life insurance", :type=>'_normal' },
			:_household =>{:id => "_household", :sentence => "Household furniture/fittings /appliances/generator", :type=>'_normal' },
			:_stocks =>{:id => "_stocks", :sentence => "Stocks", :type=>'_normal' },
			:_jewellery =>{:id => "_jewellery", :sentence => "Jewellery/precious metals", :type=>'_normal' },
			:_bonds =>{:id => "_bonds", :sentence => "Bonds", :type=>'_normal' },
			:_collectibles =>{:id => "_collectibles", :sentence => "Collectibles (vintage wines, art, etc.)", :type=>'_normal' },
			:_investment_property =>{:id => "_investment_property", :sentence => "Investment property", :type=>'_presence' },
			:_loan =>{:id => "_loan", :sentence => "Loan receivables", :type=>'_normal' },
			:_funds =>{:id => "_funds", :sentence => "Funds", :type=>'_normal' },
			:_other =>{:id => "_other", :sentence => "Other", :type=>'_normal' }
		},
		:_liabilities=> {
			:_credit_card =>{:id => "_credit_card", 		:sentence => "Credit card balances", :type=>'_normal' },
			:_bills =>{:id => "_bills", 		:sentence => "Bills Outstanding", :type=>'_normal' },
			:_consumer =>{:id => "_consumer", 		:sentence => "Consumer loans", :type=>'_normal' },
			:_mortgage =>{:id => "_mortgage", 		:sentence => "Mortgage loans", :type=>'_normal' },
			:_auto_loans =>{:id => "_auto_loans", 		:sentence => "Auto loans", :type=>'_normal' },
			:_investers =>{:id => "_investers", 		:sentence => "Investors' equity capital in own business", :type=>'_normal' },
			:_business_loans =>{:id => "_business_loans", 		:sentence => "Business loans", :type=>'_normal' }
		}
	}


	CASHFLOW_TYPE = {
		:_normal => {
			:presence => false,
			:data_type => "currency"
		},
		:_presence=>{
			:presence => true,
			:data_type => "currency"
		}
	}
	
	CASHFLOW_VALUES = {
		:_grossary_income_tax => {
			:_less_paye=> {:id => "_less_paye", :sentence=>"Less PAYE", :class=>'_grossary_income_tax_class', :selected=>true},
			:_apply_paye=>{:id => "_apply_paye", :sentence=>"Apply PAYE", :class=>'_grossary_income_tax_class'}
		},
		:_business_income_box => {
			:_less_income_tax=> {:id => "_less_income_tax", :sentence=>"Less Income tax", :class=>'_business_income_box_class', :selected=>true},
			:_apply_company_income_tax=>{:id => "_apply_company_income_tax", :sentence=>"Apply Company Income Tax", :class=>'_business_income_box_class'}
		}
	}
	
	
	CASHFLOW = {
		:_prefix => "_c",
		:_income=> {
			:_grossary_salary =>{
				:id => "_grossary_salary",								:sentence => "Gross salary/wages", :type=>'_presence' },
			:_gift_grangs =>{:id => "_gift_grangs",			:sentence => "Gifts/grants", :type=>'_normal' },
			:_grossary_income_tax =>{
				:id => "_grossary_income_tax",						:sentence => "Income tax", :type=>'_check', :values=>CASHFLOW_VALUES[:_grossary_income_tax], :class=>'_grossary_income_tax' },
			:_alimony =>{:id => "_alimony",							:sentence => "Alimony/child support receipts", :type=>'_normal' },
			:_biz_income =>{
				:id => "_biz_income",											:sentence => "Business income", :type=>'_presence' },
			:_less_paye =>{:id => "_less_paye",		 			:sentence => "Less PAYE", :type=>'_normal' },
			:_business_income_box =>{
				:id => "_business_income_box", 						:sentence => "Income tax", :type=>'_check', :values=>CASHFLOW_VALUES[:_business_income_box], :class=>'float_right large_cell' },
			:_net_salary_wages =>{
				:id => "_net_salary_wages",								:sentence => "Net salary/wages", :type=>'_normal' , :clear_line=>true},
			:_interest_dividend =>{
				:id => "_interest_dividend", 							:sentence => "Interest /dividend income", :type=>'_normal'},
			:_less_income_tax =>{
				:id => "_less_income_tax",								:sentence => "Less income tax", :type=>'_normal' },
			:_gain_on_sale =>{:id => "_gain_on_sale", 	:sentence => "Gain on sale of stocks/bonds/investment bonds", :type=>'_normal' },
			:_not_biz_income =>{
				:id => "_not_biz_income",									:sentence => "Net Business income", :type=>'_normal' },
			:_receipts_from_pension =>{
				:id => "_receipts_from_pension", 					:sentence => "Receipts from pension/retirement plans", :type=>'_normal' },
		},
		:_expenditures=> {
			:_auto_expenses =>{:id => "_auto_expenses", 	:sentence => "Auto expenses", :type=>'_normal' },
			:_other =>{:id => "_other", 									:sentence => "Other", :type=>'_normal' },
			:_food =>{:id => "_food", 										:sentence => "Food", :type=>'_normal' },
			:_rent =>{:id => "_rent",					 						:sentence => "Rent (enter annual amount)", :type=>'_normal' },
			:_telephone =>{:id => "_telephone", 					:sentence => "Telephone & utilities", :type=>'_normal' },
			:_credit_card_pay =>{:id => "_credit_card_pay",	:sentence => "Credit card payments", :type=>'_normal' },
			:_medical =>{:id => "_medical", 							:sentence => "Medical & dental expenses", :type=>'_normal' },
			:_loan_payment =>{:id => "_loan_payment", 		:sentence => "Loan payments", :type=>'_normal' },
			:_entertainment =>{:id => "_entertainment", 	:sentence => "Entertainment/recreation", :type=>'_normal' },
			:_insurance =>{:id => "_insurance", 					:sentence => "Insurance premiums", :type=>'_normal' },
			:_donations =>{:id => "_donations", 					:sentence => "Donations/tithe & offerings", :type=>'_normal' },
			:_house_maintenance =>{:id => "_house_maintenance",:sentence => "House maintenance/repairs", :type=>'_normal' },
			:_gifts =>{:id => "_gifts", 									:sentence => "Gifts", :type=>'_normal' }
		},
		:_finally_questions=> {
			:_how_old_were_you =>{:id => "_how_old_were_you",:sentence => "How old were you when you began earning an income?", :type=>'_slider', :default_value=>18, :unit=>"years old" },
			:_at_what_age =>{:id => "_at_what_age", 		:sentence => "At what age do you plan to retire?", :type=>'_slider', :default_value=>65, :unit=>"years old" }
		}
	}


	QUESTION_GROUP = {
		"TouchFeely"=>1,
		"HardFacts"=>2,
		"CashFlow"=>3
	}
	
	TRAIT_GROUP = {
		"M"=>1,
		"W"=>2,
		"S"=>3,
		"E"=>4,
		"D"=>5
	}
	
	has_many :tests
	before_create :before_insert, :only=>:create
  attr_accessible :korder, :question, :answer_type, :qgroup, :trait
	
	validates :answer_type, :question, :qgroup, :presence=>true
	
	def group_text
		QUESTION_GROUP.index(qgroup)
	end
	
	def trait_text
		TRAIT_GROUP.index(trait)
	end
	
	def answers_text
		s = ""
		ANSWER_TYPE[:"#{answer_type}"][:answers].each do |a|
			s = s + "\n * " + a[:sentence]
		end
		s
	end
	
	
	private
	def before_insert
		if Question.last==nil
			m = 1
		else
			m = Question.last[:korder] + 1
		end
		self.korder = m
	end
end
