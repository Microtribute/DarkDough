class Answer < ActiveRecord::Base
  attr_accessible :result, :question, :code

  belongs_to :acumen_test

  scope :answers_by_code, lambda { |q| { :conditions => ["code like :q", {:q => "%#{q}%"}] } }

  COMPANY_INCOME_TAX = 0.32

  QUESTIONS = [
    {"t1q01" => "A portion of your money invariably gets wasted. To think otherwise is a sign of folly or inexperience"},
    {"t1q02" => "People who are always broke are undisciplined"},
    {"t1q03" => "Money provides security"},
    {"t1q04" => "People will want to take advantage of you if they find out you are wealthy"},
    {"t1q05" => "People are essentially trustworthy"},
    {"t1q06" => "The smarter you are, the more money you'll make"},
    {"t1q07" => "It's important to diligently keep track of all income and expenditures"},
    {"t1q08" => "If I see money on the street, I'll stop to pick it up"},
    {"t1q09" => "Sometimes I buy company shares without knowing much about the company"},
    {"t1q10" => "I often worry about how much things cost"},
    {"t1q11" => "I am worried about other's financial well-being"},
    {"t1q12" => "I am not interested in theoretical discussions about my financial future"},
    {"t1q13" => "I am disciplined with my spending"},
    {"t1q14" => "I like to talk to acquaintances about my investments"},
    {"t1q15" => "I am not bothered by fluctuations in the market values of my assets"},
    {"t1q16" => "I believe people are essentially generous"},
    {"t1q17" => "I enjoy thinking about my investments"},
    {"t1q18" => "I understand just enough about my finances to get by"},
    {"t1q19" => "I enjoy owning big-name stocks"},
    {"t1q20" => "I am relaxed about investing even when the markets are down"},
    {"t1q21" => "If I am ripped off, I strive to get even"},
    {"t1q22" => "I invest my money according to a plan - for example 20% stocks, 80% real estate"},
    {"t1q23" => "I trust consensus opinion in my investing"},
    {"t1q24" => "I always read the business section of the newspaper"},
    {"t1q25" => "I try to keep track of economic events"},
    {"t1q26" => "I accurately plan my expenses"},
    {"t1q27" => "I feel very excited about the possibility of large investment gains"},
    {"t1q28" => "I never feel inclined to follow 'hot' stock picks"},
    {"t1q29" => "If I had to choose, I would prefer to"},
    {"t1q30" => "Is your answer to the previous question reflective of how you are actually spending and saving?"},
    {"t1q31" => "The currency change during the civil war"},
    {"t1q32" => "The currency devaluation during the Structural Adjustment Programme (SAP) era"},
    {"t1q33" => "The Finance House Ponzi schemes of the 1990s"},
    {"t1q34" => "The failed banks debacle of the 1990s"},
    {"t1q35" => "The wonder bank saga of the 2000s"},
    {"t1q36" => "The stock market crash of 2008"},
    {"t1q37" => "Unemployment"},
    {"t1q38" => "Business failure"},
    {"t1q39" => "Childhood poverty"},
    {"t1q40" => "Refugee status"},
    {"t1q41" => "Divorce"},
    {"t1q42" => "Accident, illness or death"},
    {"t1q43" => "Addictions"},
    {"t1q44" => "Natural disaster"},
    {"t1q45" => "How concerned are you that you will not have enough money in retirement?"},
    {"t1q46" => "Recreation"},
    {"t1q47" => "Travel"},
    {"t1q48" => "Education"},
    {"t1q49" => "Family"},
    {"t1q50" => "Spirituality/Religion"},
    {"t1q51" => "Financial"},
    {"t1q52" => "Do you feel you have sufficient assets to accomplish your goals and realise your dreams?"},
    {"t1q53" => "Charitable giving to schools, foundations, religious bodies or institutes"},
    {"t1q54" => "Spending on homes, recreation, travel, education, memberships, healthcare, and luxuries"},
    {"t1q55" => "Ensuring I have enough until the end of my life"},
    {"t1q56" => "What traditions and values in your family or community are important and should be carried on?"},
    {"t1q57" => "The amount of money you have impacts your level of happiness"},
    {"t1q58" => "You shouldn't tell others how much you have"},

    {"t2q01" => "Cash"},
    {"t2q02" => "Current & Savings account balances"},
    {"t2q03" => "Fixed deposits"},
    {"t2q04" => "Cash surrender value of life insurance"},
    {"t2q05" => "Stocks"},
    {"t2q06" => "Bonds"},
    {"t2q07" => "Investment property"},
    {"t2q08" => "Funds"},
    {"t2q09" => "Pension account balance"},
    {"t2q10" => "Market value of primary residence (if own property)"},
    {"t2q11" => "Automobiles"},
    {"t2q12" => "Household furniture/fittings/appliances/generator"},
    {"t2q13" => "Jewellery/precious metals"},
    {"t2q14" => "Collectibles (vintage wines, art, etc.)"},
    {"t2q15" => "Loan receivables"},
    {"t2q16" => "Other"},
    {"t2q17" => "Credit card balances"},
    {"t2q18" => "Consumer loans"},
    {"t2q19" => "Auto loans"},
    {"t2q20" => "Business loans"},
    {"t2q21" => "Bills outstanding"},
    {"t2q22" => "Mortgage loans"},
    {"t2q23" => "Investors' equity capital in own business"},

    {"t3q01" => "Gross salary/wages"},
    {"t3q02" => "Less PAYE"},
    {"t3q03" => "Or ... Apply PAYE? Y/N"},
    {"t3q04" => "Interest /dividend income"},
    {"t3q05" => "Gain on sale of stocks/bonds/investment bonds"},
    {"t3q06" => "Receipts from pension/retirement plans"},
    {"t3q07" => "Gifts/grants"},
    {"t3q08" => "Alimony/child support receipts"},
    {"t3q09" => "Business income"},
    {"t3q10" => "Less Income tax"},
    {"t3q11" => "Or ... Apply Company Income Tax? Y/N"},
    {"t3q12" => "Net Business income"},
    {"t3q13" => "Auto expenses"},
    {"t3q14" => "Food"},
    {"t3q15" => "Telephone & utilities"},
    {"t3q16" => "Medical & dental expenses"},
    {"t3q17" => "Entertainment/recreation"},
    {"t3q18" => "Donations/tithe & offerings"},
    {"t3q19" => "Gifts"},
    {"t3q20" => "Other"},
    {"t3q21" => "Mortgage payment"},
    {"t3q22" => "Rent (enter annual amount)"},
    {"t3q23" => "Credit card payments"},
    {"t3q24" => "Loan payments"},
    {"t3q25" => "Insurance premiums"},
    {"t3q26" => "House maintenance/repairs"},
    {"t3q27" => "How old were you when you began earning an income?"},
    {"t3q28" => "At what age do you plan to retire?"}
  ]


  ANSWERS = [ { "-2" => "Strongly disagree" },
              { "-1" => "Moderately disagree" },
              { "0"  => "Neither agree nor disagree" },
              { "1"  => "Moderately agree" },
              { "2"  => "Strongly agree" } ]

  ANSWERS_2 = [ { "-2" => "Spend more on lifestyle now and have less savings in retirement",
                  "2" => "Spend less on lifestyle now and have more savings in retirement" } ]

  ANSWERS_3 = [{"2" => "Yes" }, { "-2" => "No"}]

  ANSWERS_4_ARRAY = [ "t1q31", "t1q32", "t1q33", "t1q34", "t1q35", "t1q36", "t1q37", "t1q38", "t1q39",
                      "t1q40", "t1q41", "t1q42", "t1q43", "t1q44" ]

  ANSWERS_4 = [ { "0"  => "Me" },
                { "1"  => "Parents" },
                { "-2" => "Neither" },
                { "2"  => "Both" } ]

  ANSWERS_5 = [ { "2"  => "Extremely" },
                { "1"  => "Very" },
                { "0"  => "Moderately" },
                { "-1" => "Mildly" },
                { "-2" => "Not at all" } ]

  ANSWERS_6 = [ { "2" => "Need or would like additional income" },
                { "-2" => "Have sufficient assets" } ]

  # qulitative test
  WORRY = ["t1q01", "t1q03", "t1q10", "t1q11", "t1q45", "t1q52", "t1q57", "t1q58"]
  WORRY_EVENTS = ["t1q31", "t1q32", "t1q33", "t1q34", "t1q35", "t1q36", "t1q37",
                  "t1q38", "t1q39", "t1q40", "t1q41", "t1q42", "t1q43", "t1q44"]

  SELF_INTEREST = ["t1q01", "t1q02", "t1q04", "t1q05", "t1q06", "t1q07", "t1q08", "t1q16", "t1q22", "t1q26",
                   "t1q28", "t1q54", "t1q53", "t1q58"]
  SELF_INTEREST_DEDUCT = ["t1q18", "t1q53"]

  DISCIPLINE = ["t1q02", "t1q07", "t1q13", "t1q15", "t1q20", "t1q22", "t1q26", "t1q28", "t1q30"]

  MOTIVATION = ["t1q03", "t1q14", "t1q17", "t1q24", "t1q25", "t1q29", "t1q53"]
  MOTIVATION_DEDUCT = ["t1q18", "t1q54", "t1q55", "t1q56"]

  THRILL_SEEKING = ["t1q06", "t1q08", "t1q09", "t1q12", "t1q17", "t1q18", "t1q19", "t1q21", "t1q23", "t1q27"]
  THRILL_SEEKING_DEDUCT = ["t1q20"]

  # quantitative test
  TOTAL_INVESTMENTS = ["t2q01", "t2q02", "t2q03", "t2q04", "t2q05", "t2q06", "t2q07", "t2q08"]
  TOTAL_ASSETS = ["t2q09", "t2q10", "t2q11", "t2q12", "t2q13", "t2q14", "t2q15", "t2q16"]
  TOTAL_LIABILITIES = ["t2q17", "t2q18", "t2q19", "t2q20", "t2q21", "t2q22", "t2q23"]

  # cash flow tets
  INCOME = ['t3q04', 't3q05', 't3q06', 't3q07', 't3q08']
  TOTAL_EXPENDITURES = ['t3q13', 't3q14', 't3q15', 't3q16', 't3q17', 't3q18', 't3q19',
                        't3q20', 't3q21', 't3q23', 't3q24', 't3q25', 't3q26']
end
