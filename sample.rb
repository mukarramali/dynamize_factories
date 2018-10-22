FactoryBot.define do
  factory :xyz, :class => XYZ::XYZData do |f|
    person_id          'C965845'
    user_id            121212 # Comment with a number
    primary_contact    'XYZ Expert' # Comment with a single quoted string
    primary_contact_id 2961
    attempt_number     1
    contact_facility   { |a| a.association(:invitation) } # Comment with an association
    contact_location   1
    contact_date       Time.zone.now - 1.days
    game_start_time    "2016-08-24T20:01:01.947Z" # Comment with a double quoted string
    game_end_time      '2016-08-27T20:01:01.947Z'
    game_name          'XYZ First'
    obtained_score     50
    person_status      'Old'
    created_at         '2015-09-03 02:29:06'
    updated_at         '2017-09-03 02:29:06'
  end
end