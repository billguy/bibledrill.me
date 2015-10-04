namespace :verses do
  desc "TODO"
  task build_verse_cross_references: :environment do
    # obtained from https://github.com/souliberty/MetaV
    created_at = updated_at = DateTime.now.to_formatted_s(:db)
    VerseCrossReference.transaction do
      CSV.foreach(Rails.root.join('CrossRefIndex.csv').to_s) do |row|
        verse_id = row[0]
        cross_reference_verse_id = row[1]
        VerseCrossReference.connection.execute "INSERT INTO verse_cross_references (verse_id, cross_reference_verse_id, created_at, updated_at) values (#{verse_id}, #{cross_reference_verse_id}, '#{created_at}', '#{updated_at}')"
      end
    end
  end

  task update_verse_cross_references_count: :environment do
    Verse.find_each do |verse|
      verse.update_column(:verse_cross_references_count, verse.verse_cross_references.length)
    end
  end

end
