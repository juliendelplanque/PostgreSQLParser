Class {
	#name : #PSQLCreateTableGrammarCrashTest,
	#superclass : #PPCompositeParserTest,
	#category : #PostgreSQL-Parser-CrashTests
}

{ #category : #accessing }
PSQLCreateTableGrammarCrashTest >> parserClass [
	^ PSQLCreateTableGrammar
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand1 [
	self
		parse: 'CREATE TABLE lsmb_group ( role_name text primary key )' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand10 [
	self
		parse: 'CREATE TABLE pricegroup ( id serial PRIMARY KEY, pricegroup text )' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand11 [
	self
		parse: 'CREATE TABLE country ( id serial PRIMARY KEY, name text check (name ~ ''[[:alnum:]_]'') NOT NULL, short_name text check (short_name ~ ''[[:alnum:]_]'') NOT NULL, itu text)' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand12 [
	self
		parse: 'create table country_tax_form (country_id int  references country(id) not null, form_name text not null, id serial not null unique, default_reportable bool not null default false, is_accrual bool not null default false, primary key(country_id, form_name) )' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand13 [
	self
		parse: 'CREATE TABLE entity_class ( id serial primary key, class text check (class ~ ''[[:alnum:]_]'') NOT NULL, active boolean not null default TRUE)' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand14 [
	self
		parse: 'CREATE TABLE users ( id serial UNIQUE, username varchar(30) primary key, notify_password interval not null default ''7 days''::interval, entity_id int not null references entity(id) on delete cascade )' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand15 [
	self
		parse: 'CREATE TABLE session( session_id serial PRIMARY KEY, token VARCHAR(32) CHECK(length(token) = 32), last_used TIMESTAMP default now(), ttl int default 3600 not null, users_id INTEGER NOT NULL references users(id) on delete cascade, notify_pasword interval not null default ''7 days''::interval )' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand16 [
	self
		parse: 'CREATE TABLE open_forms ( id SERIAL PRIMARY KEY, session_id int REFERENCES session(session_id) ON DELETE CASCADE )' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand18 [
	self
		parse: 'CREATE TABLE location_class ( id serial UNIQUE, class text check (class ~ ''[[:alnum:]_]'') not null, authoritative boolean not null, PRIMARY KEY (class,authoritative))' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand19 [
	self
		parse: 'create table location_class_to_entity_class ( id serial unique, location_class int not null references location_class(id), entity_class int not null references entity_class(id) )' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand2 [
	self
		parse: 'CREATE TABLE lsmb_group_grants ( group_name text references lsmb_group(role_name), granted_role text, PRIMARY KEY (group_name, granted_role) )' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand20 [
	self
		parse: 'CREATE TABLE location ( id serial PRIMARY KEY, line_one text check (line_one ~ ''[[:alnum:]_]'') NOT NULL, line_two text, line_three text, city text check (city ~ ''[[:alnum:]_]'') NOT NULL, state text check(state ~ ''[[:alnum:]_]''), country_id integer not null REFERENCES country(id), mail_code text check (mail_code ~ ''[[:alnum:]_-]''), created date not null default now(), inactive_date timestamp default null, active boolean not null default TRUE )' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand21 [
	self
		parse: 'CREATE TABLE company ( id serial UNIQUE, entity_id integer not null references entity(id), legal_name text check (legal_name ~ ''[[:alnum:]_]''), tax_id text, sales_tax_id text, license_number text, sic_code varchar, created date default current_date not null, PRIMARY KEY (entity_id,legal_name))' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand22 [
	self
		parse: 'CREATE TABLE entity_to_location ( location_id integer references location(id) not null, location_class integer not null references location_class(id), entity_id integer not null references entity(id) ON DELETE CASCADE, PRIMARY KEY(location_id, entity_id, location_class))' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand23 [
	self
		parse: 'CREATE TABLE salutation ( id serial unique, salutation text primary key)' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand24 [
	self
		parse: 'CREATE TABLE person ( id serial PRIMARY KEY, entity_id integer references entity(id) not null, salutation_id integer references salutation(id), first_name text check (first_name ~ ''[[:alnum:]_]'') NOT NULL, middle_name text, last_name text check (last_name ~ ''[[:alnum:]_]'') NOT NULL, created date not null default current_date, birthdate date, personal_id text, unique(entity_id) )' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand25 [
	self
		parse: 'create table entity_employee (  entity_id integer references entity(id) not null unique, startdate date not null default current_date, enddate date, role varchar(20), ssn text, sales bool default ''f'', manager_id integer references entity(id), employeenumber varchar(32), dob date, is_manager bool default false, PRIMARY KEY (entity_id) )' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand26 [
	self
		parse: 'CREATE TABLE person_to_company ( location_id integer references location(id) not null, person_id integer not null references person(id) ON DELETE CASCADE, company_id integer not null references company(id) ON DELETE CASCADE, PRIMARY KEY (location_id,person_id))' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand27 [
	self
		parse: 'CREATE TABLE entity_other_name ( entity_id integer not null references entity(id) ON DELETE CASCADE, other_name text check (other_name ~ ''[[:alnum:]_]''), PRIMARY KEY (other_name, entity_id))' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand28 [
	self
		parse: 'CREATE TABLE contact_class ( id serial UNIQUE, class text check (class ~ ''[[:alnum:]_]'') NOT NULL, PRIMARY KEY (class))' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand29 [
	self
		parse: 'CREATE TABLE entity_to_contact ( entity_id integer not null references entity(id) ON DELETE CASCADE, contact_class_id integer references contact_class(id) not null, contact text check(contact ~ ''[[:alnum:]_]'') not null, description text, PRIMARY KEY (entity_id,contact_class_id,contact))' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand3 [
	self
		parse: 'CREATE TABLE lsmb_module ( id int not null unique, label text primary key )' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand30 [
	self
		parse: 'CREATE TABLE entity_bank_account ( id serial not null, entity_id int not null references entity(id) ON DELETE CASCADE, bic varchar, iban varchar, remark varchar, UNIQUE (id), PRIMARY KEY (entity_id, bic, iban) )' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand31 [
	self
		parse: 'CREATE TABLE entity_credit_account ( id serial not null unique, entity_id int not null references entity(id) ON DELETE CASCADE, entity_class int not null references entity_class(id) check ( entity_class in (1,2) ), pay_to_name text, discount numeric, description text, discount_terms int default 0, discount_account_id int references account(id), taxincluded bool default ''f'', creditlimit NUMERIC default 0, terms int2 default 0, meta_number varchar(32), business_id int, language_code varchar(6) DEFAULT ''en'' references language(code) ON DELETE SET DEFAULT, pricegroup_id int references pricegroup(id), curr char(3), startdate date DEFAULT CURRENT_DATE, enddate date, threshold numeric default 0, employee_id int references entity_employee(entity_id), primary_contact int references person(id), ar_ap_account_id int references account(id), cash_account_id int references account(id), bank_account int references entity_bank_account(id), taxform_id int references country_tax_form(id), PRIMARY KEY(entity_id, meta_number, entity_class), CHECK (ar_ap_account_id IS NOT NULL OR entity_id = 0) )' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand32 [
	self
		parse: 'CREATE TABLE eca_to_contact ( credit_id integer not null references entity_credit_account(id) ON DELETE CASCADE, contact_class_id integer references contact_class(id) not null, contact text check(contact ~ ''[[:alnum:]_]'') not null, description text, PRIMARY KEY (credit_id, contact_class_id,  contact))' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand33 [
	self
		parse: 'CREATE TABLE eca_to_location ( location_id integer references location(id) not null, location_class integer not null references location_class(id), credit_id integer not null references entity_credit_account(id) ON DELETE CASCADE, PRIMARY KEY(location_id,credit_id, location_class))' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand34 [
	self
		parse: 'CREATE TABLE employee_class ( label text not null primary key, id serial not null unique )' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand35 [
	self
		parse: 'CREATE TABLE employee_to_ec ( employee_id int references entity_employee(entity_id), ec_id int references employee_class(id), primary key(employee_id) )' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand36 [
	self
		parse: 'CREATE TABLE payroll_income_class ( id int not null, country_id int not null references country(id), label text not null, unique (id, country_id), primary key (country_id, label) )' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand37 [
	self
		parse: 'CREATE TABLE payroll_income_category ( id serial not null unique, label text )' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand38 [
	self
		parse: 'CREATE TABLE payroll_income_type ( id serial not null unique, account_id int not null references account(id), pic_id int not null, country_id int not null, label text not null, unit text not null, default_amount numeric, foreign key(pic_id, country_id) references payroll_income_class(id, country_id) )' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand39 [
	self
		parse: 'CREATE TABLE payroll_wage ( entry_id serial not null unique, entity_id int references entity(id), type_id int references payroll_income_type(id), rate numeric not null, PRIMARY KEY(entity_id, type_id) )' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand4 [
	self
		parse: 'CREATE TABLE language ( code varchar(6) PRIMARY KEY, description text )' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand40 [
	self
		parse: 'CREATE TABLE payroll_employee_class ( id serial not null unique, label text primary key )' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand41 [
	self
		parse: 'CREATE TABLE payroll_employee_class_to_income_type ( ec_id int references payroll_employee_class (id), it_id int references payroll_income_type(id), primary key(ec_id, it_id) )' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand42 [
	self
		parse: 'CREATE TABLE payroll_deduction_class ( id int not null, country_id int not null references country(id), label text not null, stored_proc_name name not null, unique (id, country_id), primary key (country_id, label) )' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand43 [
	self
		parse: 'CREATE TABLE payroll_deduction_type ( id serial not null unique, account_id int not null references account(id), pdc_id int not null, country_id int not null, label text not null, unit text not null, default_amount numeric, calc_percent bool not null, foreign key(pdc_id, country_id) references payroll_deduction_class(id, country_id) )' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand44 [
	self
		parse: 'CREATE TABLE payroll_deduction ( entry_id serial not null unique, entity_id int references entity(id), type_id int references payroll_deduction_type(id), rate numeric not null, PRIMARY KEY(entity_id, type_id) )' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand45 [
	self
		parse: 'CREATE TABLE payroll_report ( id serial not null primary key, ec_id int not null references payroll_employee_class(id), payment_date date not null, created_by int references entity_employee(entity_id), approved_by int references  entity_employee(entity_id) )' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand46 [
	self
		parse: 'CREATE TABLE payroll_report_line ( id serial not null unique, report_id int not null references payroll_report(id), employee_id int not null references entity(id), it_id int not null references payroll_income_type(id), qty numeric not null, rate numeric not null, description text, primary key (it_id, employee_id, report_id) )' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand48 [
	self
		parse: 'CREATE TABLE payroll_paid_timeoff ( employee_id int not null references entity(id), pto_class_id int not null references payroll_pto_class(id), report_id int not null references payroll_report(id), amount numeric not null )' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand49 [
	self
		parse: 'CREATE TABLE note_class(id serial primary key, class text not null check (class ~ ''[[:alnum:]_]''))' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand5 [
	self
		parse: 'CREATE TABLE account_heading ( id serial not null unique, accno text primary key, parent_id int references account_heading(id), description text, category char(1) check (category IN (''A'',''L'',''Q'',''I'',''E'')) )' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand50 [
	self
		parse: 'CREATE TABLE note (id serial primary key, note_class integer not null references note_class(id), note text not null, vector tsvector not null default '''', created timestamp not null default now(), created_by text DEFAULT SESSION_USER, ref_key integer not null, subject text)' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand51 [
	self
		parse: 'CREATE TABLE entity_note( entity_id int references entity(id), primary key(id)) INHERITS (note)' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand52 [
	self
		parse: 'CREATE TABLE invoice_note(primary key(id)) INHERITS (note)' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand53 [
	self
		parse: 'CREATE TABLE eca_note(primary key(id)) INHERITS (note)' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand54 [
	self
		parse: 'CREATE TABLE makemodel ( parts_id int, barcode text, make text, model text, primary key(parts_id, make, model) )' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand55 [
	self
		parse: 'CREATE TABLE journal_type ( id serial not null unique, name text primary key )' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand56 [
	self
		parse: 'CREATE TABLE cr_report ( id bigserial primary key not null, chart_id int not null references account(id), their_total numeric not null, approved boolean not null default ''f'', submitted boolean not null default ''f'', end_date date not null default now(), updated timestamp not null default now(), entered_by int not null default person__get_my_entity_id() references entity(id), entered_username text not null default SESSION_USER, deleted boolean not null default ''f''::boolean, deleted_by int references entity(id), approved_by int references entity(id), approved_username text, recon_fx bool default false, max_ac_id int, CHECK (deleted is not true or approved is not true) )' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand57 [
	self
		parse: 'CREATE TABLE cr_report_line ( id bigserial primary key not null, report_id int NOT NULL references cr_report(id), scn text, their_balance numeric, our_balance numeric, errorcode INT, "user" int references entity(id) not null, clear_time date, insert_time TIMESTAMPTZ NOT NULL DEFAULT now(), trans_type text, post_date date, ledger_id int, voucher_id int, overlook boolean not null default ''f'', cleared boolean not null default ''f'' )' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand59 [
	self
		parse: 'CREATE TABLE journal_entry ( id serial not null, reference text not null, description text, locked_by int references session(session_id) on delete set null, journal int references journal_type(id), post_date date not null default now(), effective_start date not null, effective_end date not null, currency char(3) not null, approved bool default false, is_template bool default false, entered_by int not null references entity(id), approved_by int references entity(id), primary key (id), check (is_template is false or approved is false) )' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand6 [
	self
		parse: 'CREATE TABLE account ( id serial not null unique, accno text primary key, description text, is_temp bool not null default false, category CHAR(1) NOT NULL check (category IN (''A'',''L'',''Q'',''I'',''E'')), gifi_accno text, heading int not null references account_heading(id), contra bool not null default false, tax bool not null default false, obsolete bool not null default false )' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand60 [
	self
		parse: 'CREATE TABLE journal_line ( id serial, account_id int references account(id)  not null, journal_id int references journal_entry(id) not null, amount numeric not null check (amount <> ''NaN''), cleared bool not null default false, reconciliation_report int references cr_report(id), line_type text references account_link_description, primary key (id) )' rule: #createTableCommand
]

{ #category : #tests }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand61 [
	self
		parse: 'CREATE TABLE eca_invoice ( order_id int, journal_id int references journal_entry(id), on_hold bool default false, reverse bool default false, credit_id int references entity_credit_account(id) not null, due date not null, language_code char(6) references language(code), force_closed bool not null default false, order_number text, PRIMARY KEY  (journal_id) )' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand62 [
	self
		parse: 'CREATE TABLE gl ( id int DEFAULT nextval ( ''id'' ) PRIMARY KEY REFERENCES transactions(id), reference text, description text, transdate date DEFAULT current_date, person_id integer references person(id), notes text, approved bool default true )' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand63 [
	self
		parse: 'CREATE TABLE lsmb_sequence ( label text primary key, setting_key text not null references defaults(setting_key), prefix text, suffix text, sequence text not null default ''1'', accept_input bool default true )' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand64 [
	self
		parse: 'CREATE TABLE batch ( id serial primary key, batch_class_id integer references batch_class(id) not null, control_code text NOT NULL, description text, default_date date not null, approved_on date default null, approved_by int references entity_employee(entity_id), created_by int references entity_employee(entity_id), locked_by int references session(session_id) ON DELETE SET NULL, created_on date default now(), CHECK (length(control_code) > 0) )' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand65 [
	self
		parse: 'CREATE TABLE voucher ( trans_id int REFERENCES transactions(id) NOT NULL, batch_id int references batch(id) not null, id serial PRIMARY KEY, batch_class int references batch_class(id) not null )' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand66 [
	self
		parse: 'CREATE TABLE acc_trans ( trans_id int NOT NULL REFERENCES transactions(id), chart_id int NOT NULL REFERENCES  account(id), amount NUMERIC NOT NULL, transdate date DEFAULT current_date, source text, cleared bool DEFAULT ''f'', fx_transaction bool DEFAULT ''f'', memo text, invoice_id int, approved bool default true, cleared_on date, reconciled_on date, voucher_id int references voucher(id), entry_id SERIAL PRIMARY KEY )' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand67 [
	self
		parse: 'CREATE TABLE parts ( id serial PRIMARY KEY, partnumber text, description text, unit varchar(5), listprice NUMERIC, sellprice NUMERIC, lastcost NUMERIC, priceupdate date DEFAULT current_date, weight numeric, onhand numeric DEFAULT 0, notes text, makemodel bool DEFAULT ''f'', assembly bool DEFAULT ''f'', alternate bool DEFAULT ''f'', rop numeric, inventory_accno_id int references account(id), income_accno_id int references account(id), expense_accno_id int references account(id), returns_accno_id int references account(id), bin text, obsolete bool DEFAULT ''f'', bom bool DEFAULT ''f'', image text, drawing text, microfiche text, partsgroup_id int, avgcost NUMERIC )' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand68 [
	self
		parse: 'CREATE TABLE mfg_lot ( id serial not null unique, lot_number text not null unique default nextval(''lot_tracking_number'')::text, parts_id int not null references parts(id), qty numeric not null, stock_date date not null default now()::date )' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand69 [
	self
		parse: 'CREATE TABLE mfg_lot_item ( id serial not null unique, mfg_lot_id int not null references mfg_lot(id), parts_id int not null references parts(id), qty numeric not null )' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand7 [
	self
		parse: 'CREATE TABLE account_checkpoint ( end_date date not null, account_id int not null references account(id), amount numeric not null, id serial not null unique, debits NUMERIC, credits NUMERIC, primary key (end_date, account_id) )' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand70 [
	self
		parse: 'CREATE TABLE invoice ( id serial PRIMARY KEY, trans_id int REFERENCES transactions(id), parts_id int REFERENCES parts(id), description text, qty NUMERIC, allocated NUMERIC, sellprice NUMERIC, precision int, fxsellprice NUMERIC, discount numeric, assemblyitem bool DEFAULT ''f'', unit varchar, deliverydate date, serialnumber text, vendor_sku text, notes text )' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand71 [
	self
		parse: 'CREATE TABLE payment_map ( line_id int references journal_line(id), pays int references eca_invoice(journal_id) not null, primary key(line_id) )' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand72 [
	self
		parse: 'CREATE TABLE journal_note ( internal_only bool not null default false, primary key (id), check(note_class = 5), foreign key(ref_key) references journal_entry(id) ) INHERITS (note)' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand73 [
	self
		parse: 'CREATE TABLE assembly ( id int REFERENCES parts(id) on delete cascade, parts_id int REFERENCES parts(id), qty numeric, bom bool, adj bool, PRIMARY KEY (id, parts_id) )' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand74 [
	self
		parse: 'CREATE TABLE ar ( id int DEFAULT nextval ( ''id'' ) PRIMARY KEY REFERENCES transactions(id), invnumber text, transdate date DEFAULT current_date, entity_id int REFERENCES entity(id), taxincluded bool, amount NUMERIC, netamount NUMERIC, paid NUMERIC, datepaid date, duedate date, invoice bool DEFAULT ''f'', shippingpoint text, terms int2 DEFAULT 0, notes text, curr char(3) CHECK ( (amount IS NULL AND curr IS NULL) OR (amount IS NOT NULL AND curr IS NOT NULL)), ordnumber text, person_id integer references entity_employee(entity_id), till varchar(20), quonumber text, intnotes text, shipvia text, language_code varchar(6), ponumber text, on_hold bool default false, reverse bool default false, approved bool default true, entity_credit_account int references entity_credit_account(id) not null, force_closed bool, description text, is_return bool default false, crdate date, setting_sequence text, check (invnumber is not null or not approved) )' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand75 [
	self
		parse: 'CREATE TABLE ap ( id int DEFAULT nextval ( ''id'' ) PRIMARY KEY REFERENCES transactions(id), invnumber text, transdate date DEFAULT current_date, entity_id int REFERENCES entity(id), taxincluded bool DEFAULT ''f'', amount NUMERIC, netamount NUMERIC, paid NUMERIC, datepaid date, duedate date, invoice bool DEFAULT ''f'', ordnumber text, curr char(3) CHECK ( (amount IS NULL AND curr IS NULL) OR (amount IS NOT NULL AND curr IS NOT NULL)) , -- This can be null, but shouldn''t be. notes text, person_id integer references entity_employee(entity_id), till varchar(20), quonumber text, intnotes text, shipvia text, language_code varchar(6), ponumber text, shippingpoint text, on_hold bool default false, approved bool default true, reverse bool default false, terms int2 DEFAULT 0, description text, force_closed bool, crdate date, is_return bool default false, entity_credit_account int references entity_credit_account(id) NOT NULL )' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand76 [
	self
		parse: 'CREATE TABLE inventory_report_line ( adjust_id int REFERENCES inventory_report(id), parts_id int REFERENCES parts(id), counted numeric, expected numeric, variance numeric, PRIMARY KEY (adjust_id, parts_id) )' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand77 [
	self
		parse: 'CREATE TABLE taxcategory ( taxcategory_id serial PRIMARY KEY, taxcategoryname text NOT NULL, taxmodule_id int NOT NULL, FOREIGN KEY (taxmodule_id) REFERENCES taxmodule (taxmodule_id) )' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand78 [
	self
		parse: 'CREATE TABLE partstax ( parts_id int, chart_id int, taxcategory_id int, PRIMARY KEY (parts_id, chart_id), FOREIGN KEY (parts_id) REFERENCES parts (id) on delete cascade, FOREIGN KEY (chart_id) REFERENCES  account(id), FOREIGN KEY (taxcategory_id) REFERENCES taxcategory (taxcategory_id) )' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand79 [
	self
		parse: 'CREATE TABLE oe_class ( id smallint unique check(id IN (1,2,3,4)), oe_class text primary key)' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand8 [
	self
		parse: 'CREATE TABLE account_link_description ( description text    primary key, summary     boolean not null, custom      boolean not null )' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand80 [
	self
		parse: 'CREATE TABLE oe ( id serial PRIMARY KEY, ordnumber text, transdate date default current_date, entity_id integer references entity(id), amount NUMERIC, netamount NUMERIC, reqdate date, taxincluded bool, shippingpoint text, notes text, curr char(3), person_id integer references person(id), closed bool default ''f'', quotation bool default ''f'', quonumber text, intnotes text, shipvia text, language_code varchar(6), ponumber text, terms int2 DEFAULT 0, entity_credit_account int references entity_credit_account(id) not null, oe_class_id int references oe_class(id) NOT NULL )' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand81 [
	self
		parse: 'CREATE TABLE orderitems ( id serial PRIMARY KEY, trans_id int, parts_id int, description text, qty numeric, sellprice NUMERIC, precision int, discount numeric, unit varchar(5), reqdate date, ship numeric, serialnumber text, notes text )' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand82 [
	self
		parse: 'CREATE TABLE exchangerate ( curr char(3), transdate date, buy numeric, sell numeric, PRIMARY KEY (curr, transdate) )' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand83 [
	self
		parse: 'CREATE TABLE business_unit_class ( id serial not null unique, label text primary key, active bool not null default false, ordering int )' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand84 [
	self
		parse: 'CREATE TABLE bu_class_to_module ( bu_class_id int references business_unit_class(id), module_id int references lsmb_module(id), primary key (bu_class_id, module_id) )' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand85 [
	self
		parse: 'CREATE TABLE business_unit ( id serial PRIMARY KEY, class_id int not null references business_unit_class(id), control_code text, description text, start_date date, end_date date, parent_id int references business_unit(id), credit_id int references entity_credit_account(id), UNIQUE(id, class_id), UNIQUE(class_id, control_code) )' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand86 [
	self
		parse: 'CREATE TABLE job ( bu_id int primary key references business_unit(id), parts_id int, production numeric default 0, completed numeric default 0 )' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand87 [
	self
		parse: 'CREATE TABLE business_unit_jl ( entry_id int references journal_line(id), bu_class int references business_unit_class(id), bu_id int references business_unit(id) NOT NULL, PRIMARY KEY(entry_id, bu_class) )' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand88 [
	self
		parse: 'CREATE TABLE business_unit_ac ( entry_id int references acc_trans(entry_id) on delete cascade, class_id int references business_unit_class(id), bu_id int, primary key(bu_id, class_id, entry_id), foreign key(class_id, bu_id) references business_unit(class_id, id) )' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand89 [
	self
		parse: 'CREATE TABLE business_unit_inv ( entry_id int references invoice(id) on delete cascade, class_id int references business_unit_class(id), bu_id int, primary key(bu_id, class_id, entry_id), foreign key(class_id, bu_id) references business_unit(class_id, id) )' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand9 [
	self
		parse: 'CREATE TABLE account_link ( account_id int references account(id) on delete cascade, description text references account_link_description(description), primary key (account_id, description) )' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand90 [
	self
		parse: 'CREATE TABLE business_unit_oitem ( entry_id int references orderitems(id) on delete cascade, class_id int references business_unit_class(id), bu_id int, primary key(bu_id, class_id, entry_id), foreign key(class_id, bu_id) references business_unit(class_id, id) )' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand91 [
	self
		parse: 'CREATE TABLE budget_info ( id serial not null unique, start_date date not null, end_date date not null, reference text primary key, description text not null, entered_by int not null references entity(id) default person__get_my_entity_id(), approved_by int references entity(id), obsolete_by int references entity(id), entered_at timestamp not null default now(), approved_at timestamp, obsolete_at timestamp, check (start_date < end_date) )' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand92 [
	self
		parse: 'CREATE TABLE budget_to_business_unit ( budget_id int not null unique references budget_info(id), bu_id int not null references business_unit(id), bu_class int references business_unit_class(id), primary key (budget_id, bu_class) )' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand93 [
	self
		parse: 'CREATE TABLE budget_line ( budget_id int not null references budget_info(id), account_id int not null references account(id), description text, amount numeric not null, primary key (budget_id, account_id) )' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand94 [
	self
		parse: 'CREATE TABLE budget_note ( primary key(id), check (note_class = 6), foreign key(ref_key) references budget_info(id) ) INHERITS (note)' rule: #createTableCommand
]

{ #category : #'as yet unclassified' }
PSQLCreateTableGrammarCrashTest >> testCreateTableCommand95 [
	self
		parse: 'CREATE TABLE audittrail ( trans_id int, tablename text, reference text, formname text, action text, transdate timestamp default current_timestamp, person_id integer references person(entity_id) not null, entry_id BIGSERIAL PRIMARY KEY )' rule: #createTableCommand
]
