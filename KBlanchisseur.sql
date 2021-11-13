INSERT INTO `addon_account` (name, label, shared) VALUES 
	('society_blanchi','Blanchisseur',1)
;

INSERT INTO `datastore` (name, label, shared) VALUES 
	('society_blanchi','Blanchisseur',1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES 
	('society_blanchi', 'Blanchisseur', 1)
;

INSERT INTO `jobs` (`name`, `label`, `SecondaryJob`) VALUES
('blanchi', 'Blanchisseur', 1);

INSERT INTO `job_grades` (`id`, `job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
('111','blanchi', 0, 'soldato', 'Recrue', 200, 'null', 'null'),
('112','blanchi', 1, 'capo', 'Membre', 400, 'null', 'null'),
('113','blanchi', 2, 'consigliere', 'Bras-Droit', 600, 'null', 'null'),
('114','blanchi', 3, 'boss', 'Patron', 1000, 'null', 'null');