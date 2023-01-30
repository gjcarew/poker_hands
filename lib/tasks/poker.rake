namespace :poker do
  desc "Load the data from the given CSV to the Postgres db"
  task load_from_txt: :environment do
    player1 = Player.create!(name: 'Player 1')
    player2 = Player.create!(name: 'Player 2')
    puts 'Loading data...'

    File.foreach('lib/assets/poker.txt') do |line|
      cards_arr = line.split(' ')
      round = Round.create!

      p1_hand = round.hands.create!(player: player1)
      cards_arr[0..4].each do |card_txt|
        p1_hand.cards << Card.find_or_create_by(txt: card_txt)
      end

      p2_hand = round.hands.create!(player: player2)
      cards_arr[5..9].each do |card_txt|
        p2_hand.cards << Card.find_or_create_by(txt: card_txt)
      end

      round.find_winner
    end
    puts 'Text file loaded to database'
  end

  desc 'How many wins does player 1 have?'
  task winner: :environment do
    puts Round.where(winner: 1).count
  end

end
