namespace :poker do
  desc "Load the data from the given CSV to the Postgres db"
  task load_from_txt: :environment do
    player1 = Player.create!(name: 'Player 1')
    player2 = Player.create!(name: 'Player 2')

    File.foreach("lib/assets/poker.txt") do |line|
      cards_arr = line.split(' ')
      round = Round.create!()
      p1_hand = round.hands.create!(player: player1)
      

    end
  end

  desc "How many wins does player 1 have?"
  task winner: :environment do
  end

end
