namespace :verses do
  desc "TODO"
  task build_verse_cross_references: :environment do
    # obtained from https://github.com/souliberty/MetaV
    current_verse_id, current_verse = nil, nil
    CSV.foreach(Rails.root.join('CrossRefIndex.csv').to_s) do |row|
      puts $.
      verse_id = row[0]
      cross_reference_verse_id = row[1]
      if verse_id != current_verse_id
        current_verse_id = verse_id
        current_verse = Verse.find(verse_id)
      end
      current_verse.verse_cross_references.create(verse_id: cross_reference_verse_id) unless current_verse.verse_cross_reference_ids.include?(current_verse.verses)
    end
  end

end
