require 'mechanize'

class CodewarsGateway
  def overall_leaders
    agent = Mechanize.new
    leaderboard_page = agent.get('https://www.codewars.com/users/leaderboard')
    leaderboard_table = leaderboard_page.search('table')
    leaderboard_rows = leaderboard_table.search('tr')
    leaderboard_rows[1..-1].map { |row|
      columns = row.search('td')
      name = columns[1].search('a').text.strip
      clan = columns[2].text.strip
      honor = columns[3].text.strip.delete(',').to_i
      {
        name:   name,
        clan:   clan,
        honor:  honor
      }
    }
  end
end
