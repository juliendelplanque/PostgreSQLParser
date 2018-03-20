"
I represent a keyword.

e.g. 'SELECT'

My class side can test a string to determinate if it is included in the list of known keywords of PostgreSQL.
"
Class {
	#name : #PSQLKeyword,
	#superclass : #PSQLToken,
	#category : 'PostgreSQL-Old'
}

{ #category : #testing }
PSQLKeyword class >> isKeyword: aString [
	^ self keywordList includes: aString asUppercase
]

{ #category : #accessing }
PSQLKeyword class >> keywordList [
	"https://www.postgresql.org/docs/9.5/static/sql-keywords-appendix.html"
	^ #(ALL ANALYSE ANALYZE AND ANY ARRAY AS ASC ASYMMETRIC BOTH CASE CAST CHECK COLLATE COLUMN CONSTRAINT CREATE CURRENT_CATALOG CURRENT_DATE CURRENT_ROLE CURRENT_TIME CURRENT_TIMESTAMP CURRENT_USER DEFAULT DEFERRABLE DESC DISTINCT DO ELSE END EXCEPT FALSE FETCH FOR FOREIGN FROM GRANT GROUP HAVING IN INITIALLY INTERSECT INTO LATERAL LEADING LIMIT LOCALTIME LOCALTIMESTAMP NOT NULL OFFSET ON ONLY OR ORDER PLACING PRIMARY REFERENCES RETURNING SELECT SESSION_USER SOME SYMMETRIC TABLE THEN TO TRAILING TRUE UNION UNIQUE USER USING VARIADIC WHEN WHERE WINDOW WITH)
]
