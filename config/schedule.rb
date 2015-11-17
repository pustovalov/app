every 1.day, at: 00:00 do
  rake "pending_cards", output: "log/cron.log"
end
