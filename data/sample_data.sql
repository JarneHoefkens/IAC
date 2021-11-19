INSERT INTO `users` (`id`, `firstname`, `lastname`, `password`, `username`, `email`, `admin`, `active`, `created_at`) VALUES
(1, 'Lien', 'Houdenaert', '$1$bcqkfRiY$a4Dm.i5TdPkqvYeYYBkvb/', 'lienhoudenaert', 'lien.houdenaert@gmail.com', 1, 1, '2021-10-30 18:19:36'),
(2, 'Maxim', 'Zeelmaekers', '$1$8XVFWf2w$FX6VASag6k/Kl4z3Sg3kL.', 'maximzeelmaekers', 'maxim.zeelmaekers@gmail.com', 1, 1, '2021-10-30 18:22:16'),
(3, 'Jarne', 'Hoefkens', '$1$t.L3rZWw$Y2.J0V8MyfGk1oqJF8.010', 'jarnehoefkens', 'jarne.hoefkens@telenet.be', 0, 1, '2021-10-30 18:27:48');

INSERT INTO `tickets` (`id`, `name`, `email`, `username`, `subject`, `priority`, `message`, `created_at`) VALUES
(1, 'Lien Houdenaert', 'lien.houdenaert@gmail.com', 'lienhoudenaert', 'Test1', '1', 'Dit is de eerste test!', '2021-10-30 18:30:54'),
(2, 'Jarne Hoefkens', 'jarne.hoefkens@telenet.be', 'jarnehoefkens', 'Test2', '2', 'Dit is de tweede test!', '2021-10-30 18:33:01'),
(3, 'Maxim Zeelmaekers', 'maxim.zeelmaekers@gmail.com', 'maximzeelmaekers', 'Test3', '3', 'Dit is de derde test!', '2021-10-30 18:33:22');