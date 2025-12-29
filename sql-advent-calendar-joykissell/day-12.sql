-- SQL Advent Calendar - Day 12
-- Title: North Pole Network Most Active Users
-- Difficulty: hard
--
-- Question:
-- The North Pole Network wants to see who's the most active in the holiday chat each day. Write a query to count how many messages each user sent, then find the most active user(s) each day. If multiple users tie for first place, return all of them.
--
-- The North Pole Network wants to see who's the most active in the holiday chat each day. Write a query to count how many messages each user sent, then find the most active user(s) each day. If multiple users tie for first place, return all of them.
--

-- Table Schema:
-- Table: npn_users
--   user_id: INT
--   user_name: VARCHAR
--
-- Table: npn_messages
--   message_id: INT
--   sender_id: INT
--   sent_at: TIMESTAMP
--

-- My Solution:

WITH msg_count AS(
  SELECT sender_id, DATE(sent_at) AS days, COUNT(*) AS msg_count
  FROM npn_messages
  GROUP BY sender_id, days
  ORDER BY days, msg_count
),
ranked AS(
  SELECT sender_id, days, msg_count,
    RANK() OVER(PARTITION BY days ORDER BY msg_count DESC) AS rnk
  FROM msg_count
)

SELECT n.user_name, r.days, r.msg_count 
FROM ranked r
  JOIN npn_users n 
    ON r.sender_id = n.user_id
WHERE rnk = 1
  ORDER BY r.days ASC;
