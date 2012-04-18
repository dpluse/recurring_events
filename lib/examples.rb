def examples
examples = []
examples[0] = "---
:start_date: 2012-04-10 16:23:42.241685000 +01:00
:rrules:
- :validations:
    :month_of_year:
    - 10
    :day_of_month:
    - 13
    :day:
    - 5
  :rule_type: IceCube::YearlyRule
  :interval: 1
:exrules: []
:rtimes: []
:extimes: []
"
examples[1] = "---
:start_date: 2012-04-10 16:23:42.243192000 +01:00
:rrules:
- :validations:
    :day_of_month:
    - 13
    :day:
    - 5
    :month_of_year:
    - 10
  :rule_type: IceCube::YearlyRule
  :interval: 1
:exrules: []
:rtimes: []
:extimes: []
"
examples[2] = "---
:start_date: 2012-04-10 16:23:42.243558000 +01:00
:rrules:
- :validations:
    :day_of_month:
    - 13
    :day:
    - 5
    :month_of_year:
    - 10
  :rule_type: IceCube::YearlyRule
  :interval: 1
:exrules: []
:rtimes: []
:extimes: []
"
examples[3] = "---
:start_date: 2012-04-10 16:23:42.243918000 +01:00
:rrules:
- :validations:
    :day:
    - 5
    :day_of_month:
    - 13
    :month_of_year:
    - 10
  :rule_type: IceCube::WeeklyRule
  :interval: 2
:exrules: []
:rtimes: []
:extimes: []
"
examples[4] = "---
:start_date: 2012-04-10 16:23:42.244261000 +01:00
:rrules:
- :validations:
    :day_of_month:
    - 13
    :day:
    - 5
    :month_of_year:
    - 10
  :rule_type: IceCube::WeeklyRule
  :interval: 2
:exrules: []
:rtimes: []
:extimes: []
"
examples[5] = "---
:start_date: 2012-04-10 16:23:42.244605000 +01:00
:rrules:
- :validations: {}
  :rule_type: IceCube::DailyRule
  :interval: 1
:exrules: []
:rtimes: []
:extimes: []
"
examples[6] = "---
:start_date: 2012-04-10 16:23:42.244895000 +01:00
:rrules:
- :validations: {}
  :rule_type: IceCube::DailyRule
  :interval: 3
:exrules: []
:rtimes: []
:extimes: []
"
examples[7] = "---
:start_date: 2012-04-10 16:23:42.245159000 +01:00
:rrules:
- :validations: {}
  :rule_type: IceCube::WeeklyRule
  :interval: 1
:exrules: []
:rtimes: []
:extimes: []
"
examples[8] = "---
:start_date: 2012-04-10 16:23:42.245429000 +01:00
:rrules:
- :validations:
    :day:
    - 1
    - 2
  :rule_type: IceCube::WeeklyRule
  :interval: 2
:exrules: []
:rtimes: []
:extimes: []
"
examples[9] = "---
:start_date: 2012-04-10 16:23:42.245733000 +01:00
:rrules:
- :validations:
    :day:
    - 1
    - 2
  :rule_type: IceCube::WeeklyRule
  :interval: 2
:exrules: []
:rtimes: []
:extimes: []
"
examples[10] = "---
:start_date: 2012-04-10 16:23:42.246033000 +01:00
:rrules:
- :validations:
    :day_of_month:
    - 1
    - -1
  :rule_type: IceCube::MonthlyRule
  :interval: 1
:exrules: []
:rtimes: []
:extimes: []
"
examples[11] = "---
:start_date: 2012-04-10 16:23:42.246337000 +01:00
:rrules:
- :validations:
    :day_of_month:
    - 15
  :rule_type: IceCube::MonthlyRule
  :interval: 2
:exrules: []
:rtimes: []
:extimes: []
"
examples[12] = "---
:start_date: 2012-04-10 16:23:42.246627000 +01:00
:rrules:
- :validations:
    :day_of_week:
      2:
      - 1
      - -1
  :rule_type: IceCube::MonthlyRule
  :interval: 1
:exrules: []
:rtimes: []
:extimes: []
"
examples[13] = "---
:start_date: 2012-04-10 16:23:42.246935000 +01:00
:rrules:
- :validations:
    :day_of_week:
      1:
      - 1
      2:
      - -1
  :rule_type: IceCube::MonthlyRule
  :interval: 2
:exrules: []
:rtimes: []
:extimes: []
"
examples[14] = "---
:start_date: 2012-04-10 16:23:42.247269000 +01:00
:rrules:
- :validations:
    :day_of_week:
      1:
      - 1
      2:
      - -1
  :rule_type: IceCube::MonthlyRule
  :interval: 2
:exrules: []
:rtimes: []
:extimes: []
"
examples[15] = "---
:start_date: 2012-04-10 16:23:42.247664000 +01:00
:rrules:
- :validations:
    :day_of_year:
    - 100
    - -100
  :rule_type: IceCube::YearlyRule
  :interval: 1
:exrules: []
:rtimes: []
:extimes: []
"
examples[16] = "---
:start_date: 2012-04-10 16:23:42.247989000 +01:00
:rrules:
- :validations:
    :day_of_year:
    - -1
  :rule_type: IceCube::YearlyRule
  :interval: 4
:exrules: []
:rtimes: []
:extimes: []
"
examples[17] = "---
:start_date: 2012-04-10 16:23:42.248278000 +01:00
:rrules:
- :validations:
    :month_of_year:
    - 1
    - 2
  :rule_type: IceCube::YearlyRule
  :interval: 1
:exrules: []
:rtimes: []
:extimes: []
"
examples[18] = "---
:start_date: 2012-04-10 16:23:42.248567000 +01:00
:rrules:
- :validations:
    :month_of_year:
    - 3
  :rule_type: IceCube::YearlyRule
  :interval: 3
:exrules: []
:rtimes: []
:extimes: []
"
examples[19] = "---
:start_date: 2012-04-10 16:23:42.248858000 +01:00
:rrules:
- :validations:
    :month_of_year:
    - 3
  :rule_type: IceCube::YearlyRule
  :interval: 3
:exrules: []
:rtimes: []
:extimes: []
"
examples[20] = "---
:start_date: 2012-04-10 16:23:42.249144000 +01:00
:rrules:
- :validations: {}
  :rule_type: IceCube::HourlyRule
  :interval: 1
:exrules: []
:rtimes: []
:extimes: []
"
examples[21] = "---
:start_date: 2012-04-10 16:23:42.249404000 +01:00
:rrules:
- :validations:
    :day:
    - 1
  :rule_type: IceCube::HourlyRule
  :interval: 2
:exrules: []
:rtimes: []
:extimes: []
"
examples[22] = "---
:start_date: 2012-04-10 16:23:42.249707000 +01:00
:rrules:
- :validations: {}
  :rule_type: IceCube::MinutelyRule
  :interval: 10
:exrules: []
:rtimes: []
:extimes: []
"
examples[23] = "---
:start_date: 2012-04-10 16:23:42.249995000 +01:00
:rrules:
- :validations:
    :day_of_week:
      2:
      - -1
  :rule_type: IceCube::MinutelyRule
  :interval: 90
:exrules: []
:rtimes: []
:extimes: []
"
examples
end