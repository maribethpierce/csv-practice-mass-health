require 'csv'
require 'pg'
require 'pry'

def db_connection
  begin
    connection = PG.connect(dbname: "mass_health")
    yield(connection)
  ensure
    connection.close
  end
end

records = CSV.read('mass-chip-data.csv', headers:true)

db_connection do |conn|
  records.each do |row|
    population_total = row['total pop, year 2005'].gsub(',', '')
    pop_youth = row['age 0-19, year 2005'].gsub(',', '')
    pop_elder = row['age 65+, year 2005'].gsub(',', '')
    income = row['Per Capita Income, year 2000'].gsub('.', '')
    poverty_num = row['Persons Living Below 200% Poverty, year 2000']
    poverty_percent = row['% all Persons Living Below 200% Poverty Level, year 2000']
    poverty_indicators = "adequacy,c_section,inf_death,inf_mort,low_birthwt,multi_birth,public_financ,teen_birth"
    sql = "INSERT INTO prenatal_care (#{poverty_indicators}) VALUES ($1,$2,$3,$4,$5,$6,$7,$8)"
    # geography_id = conn.exec("SELECT id FROM geography WHERE town_name = $1",[row['Geography']])[0]['id']
    adeqacy_ind = row['% adequacy prenatal care (kotelchuck)'].gsub('NA', '0')
    c_section_rate = row['% C-section deliveries, 2005-2008'].gsub('NA', '0')
    inf_death_no = row['Number of infant deaths, 2005-2008'].gsub('NA', '0')
    inf_mort_no = row['Infant mortality rate (deaths per 1000 live births), 2005-2008'].gsub('NA', '0')
    low_birthwt_num = row['% low birthweight 2005-2008'].gsub('NA', '0')
    multi_birth_num = row['% multiple births, 2005-2008'].gsub('NA', '0')
    pub_fin_care = row['% publicly financed prenatal care, 2005-2008'].gsub('NA', '0')
    teen_birth_num = row['% teen births, 2005-2008'].gsub('N/A', '0').gsub('NA', '0')
    town_array = [conn.exec("SELECT * FROM geography")]
    if town_array.include?(row['Geography'])
      nil
    else
      conn.exec("INSERT INTO geography (town_name) VALUES ($1)", [row['Geography']])
      conn.exec("INSERT INTO population (total_pop, youth_pop, elder_pop) VALUES ($1,$2,$3)", [population_total, pop_youth, pop_elder])
      conn.exec("INSERT INTO income (per_cap_income) VALUES ($1)", [income])
      conn.exec("INSERT INTO poverty (num, percentage) VALUES ($1,$2)", [poverty_num, poverty_percent])
      conn.exec(sql, [
          adeqacy_ind,
          c_section_rate,
          inf_death_no,
          inf_mort_no,
          low_birthwt_num,
          multi_birth_num,
          pub_fin_care,
          teen_birth_num
          ])
      end
  end
  binding.pry
    geography_id = conn.exec("SELECT id FROM geography;")
    population_id = conn.exec("SELECT id FROM population;")
    income_id = conn.exec("SELECT id FROM income;")
    poverty_id = conn.exec("SELECT id FROM poverty;")
    prenatal_care_id = conn.exec("SELECT id FROM prenatal_care;")
    healthcare_columns = 'geography_id,population_id,income_id, poverty_id,prenatal_care_id'
    sql_healthcare = "INSERT INTO healthcare (#{healthcare_columns}) VALUES ($1,$2,$3,$4,$5)"

      conn.exec(sql_healthcare, [
          geography_id.to_i, population_id.to_i, income_id.to_i, poverty_id.to_i, prenatal_care_id.to_i
          ])
end
