More notes complete!
## Data Structures:
Everything has an associated pkid even if it isn't listed

### Editable (Trait)
All things include this trait (as all things are editable)
- created (Date)
- modified (Date)
- deleted (Date)
- last_actor (User)

### Task
- title (String)
- description (String)
- due_date (Date)
- complete (Boolean)
- points (Value)
- repeat_days (String)
    - Represents the days of the week this task repeats on. MTWRFSU
- repeat_frequency (String)
    - Represents how often a task repeats. (Daily, Weekly, Bi-Weekly, Monthly, Bi-Monthly, Yearly)
- repeat_until (Date)
- owner (User)
- motivation (Motivation(List))
- comments (Comment(List))
- attachments (File(List))
- chain (Int)

### Value
- motivation (Int)
- chain (Int)
- base (Int)
- total (Int)

### User
- username (String)
- auth_token (String)
    - some way to store password or something
- friends (User(List))
- points (Value)
- tasks (Task(List))
- motivation_given (Motivation(List))
- motivation_received (Motivation(List))

### Motivation
- motivator (User)
- motivatee (User)
- motivated (Task)
- points (int)

### Inspiration (ext Motivation)
- message (String)
- attachments (File(List))

### Comment
- task (Task)
- commentor (User)
- message (String)

### File
- title (String)
- url (String)
    - Location of the file
