-- SQL Advent Calendar - Day 18
-- Title: 12 Days of Data - Progress Tracking
-- Difficulty: hard
--
-- Question:
-- Over the 12 days of her data challenge, Data Dawn tracked her daily quiz scores across different subjects. Can you find each subject's first and last recorded score to see how much she improved?
--
-- Over the 12 days of her data challenge, Data Dawn tracked her daily quiz scores across different subjects. Can you find each subject's first and last recorded score to see how much she improved?
--

-- Table Schema:
-- Table: daily_quiz_scores
--   subject: VARCHAR
--   quiz_date: DATE
--   score: INTEGER
--

-- My Solution:

WITH datedAsc AS(
  SELECT *,
    ROW_NUMBER() OVER(PARTITION BY subject ORDER BY quiz_date ASC) AS oldest,
    ROW_NUMBER() OVER(PARTITION BY subject ORDER BY quiz_date DESC) AS newest
  FROM daily_quiz_scores
)
SELECT a.subject, a.first_score, b.last_score
FROM
(SELECT subject, score AS first_score
  FROM datedAsc
  WHERE oldest = 1) a
JOIN
(SELECT subject, score AS last_score
  FROM datedAsc
  WHERE newest = 1) b
ON a.subject = b.subject;
