-- For now pledge classes are just their greek letter titles.
-- However for future-proofing we're having them be their own table in the DB.
CREATE TABLE PledgeClass(
    id SERIAL PRIMARY KEY, 
    name TEXT NOT NULL,
)

-- Any former or current member in the organization. 
CREATE TABLE Member(
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    pledge_class_id NOT NULL INTEGER REFERENCES PledgeClass(id),

    -- Dates are specified as YYYYMMDD, which allows for easy sorting. 
    -- Dates with NULL days will have DD = 99, pushing them all the way
    -- to the back of the sort. 
    join_date INTEGER, 
    graduation_date INTEGER, 
    is_active BOOLEAN NOT NULL DEFAULT FALSE, 
)

CREATE TABLE FamilyGroup(
    id SERIAL PRIMARY KEY, 
    name TEXT NOT NULL,
)

CREATE TABLE Family(
    id SERIAL PRIMARY KEY, 
    name TEXT NOT NULL,
    group INTEGER REFERENCES FamilyGroup(id),
)

CREATE TABLE FamilyCreation(
    id SERIAL PRIMARY KEY,
    family INTEGER NOT NULL REFERENCES Family(id),
    date INTEGER,
)

-- Since the founding system is many-to-many we include another link table between
-- family creation and founder. 
CREATE TABLE FamilyFounder(
    id SERIAL PRIMARY KEY, 
    family_creation INTEGER NOT NULL REFERENCES FamilyCreation(id),
    member INTEGER NOT NULL REFERENCES Member(id),
)

CREATE TABLE Pickup(
    id SERIAL PRIMARY KEY, 
    big INTEGER NOT NULL REFERENCES Member(id),
    little INTEGER NOT NULL REFERENCES Member(id),
    adoption BOOLEAN NOT NULL DEFAULT FALSE,
    date INTEGER NOT NULL,
    family INTEGER REFERENCES Family(id),
)

