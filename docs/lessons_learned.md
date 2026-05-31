# Analytics Engineering Project – Setup Lessons Learned

## Git & GitHub

### Error: `src refspec main does not match any`

**Cause**

* Attempted to push before creating the first commit.

**Checklist**

```bash
git status
git add .
git commit -m "Initial commit"
git push -u origin main
```

---

### Error: `fatal: not a git repository`

**Cause**

* Running Git commands outside the repository folder.

**Checklist**

```bash
pwd
git status
```

Verify the `.git` folder exists in the current directory.

---

### Error: Author identity unknown

**Cause**

* Git username and email not configured.

**Fix**

```bash
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
```

---

## Python Virtual Environment

### Error: `venvScriptsactivate: command not found`

**Cause**

* Used Windows activation syntax inside Git Bash.

**Fix (Git Bash)**

```bash
source venv/Scripts/activate
```

**Verify**

```bash
which python
```

Should point to the virtual environment.

---

## dbt Installation

### Issue: dbt installation errors with Python 3.14

**Cause**

* dbt 1.7.x is not fully compatible with Python 3.14.

**Fix**

* Install Python 3.11.
* Create a new virtual environment.
* Reinstall dbt.

**Verify**

```bash
python --version
dbt --version
```

---

## dbt Setup

### Error: `dbt: command not found`

**Cause**

* Virtual environment not activated.

**Fix**

```bash
source venv/Scripts/activate
```

---


## BigQuery & Service Account

### Required Service Account Roles

Minimum roles:

* BigQuery Job User
* BigQuery Data Editor

---

### Authentication Check

Verify `profiles.yml` contains:

```yaml
method: service-account
keyfile: path/to/keyfile.json
```

Location:

```text
C:\Users\<username>\.dbt\profiles.yml
```

---

## BigQuery Regions

### Public Dataset Access Issues

**Symptom**

```text
Access Denied
```

when querying a public dataset through dbt.

**Root Cause**

* Region mismatch between:

  * dbt execution location
  * source dataset location
  * target dataset location

**Checklist**

Verify `profiles.yml`:

```yaml
location: US
```

Verify target dataset location:

```text
ecommerce_dev → US
```

---

### Error: Dataset not found in location US

**Cause**

* Dataset existed in a different region (EU).

**Fix**

* Create the dataset in the same region as the source dataset.

Example:

```text
ecommerce_dev → US
```

---

## dbt Workflow

### Before Running Models

Always run:

```bash
dbt debug
```

Expected result:

```text
All checks passed
```

---

### After Profile Changes

Run:

```bash
dbt debug
```

before:

```bash
dbt run
```

---

## Project Structure

Current structure:

```text
models/
├── staging/
│   └── thelook/
│       ├── stg_orders.sql
│       ├── stg_users.sql
│       ├── stg_products.sql
│       └── _sources.yml
│
├── marts/
│   ├── dimensions/
│   └── facts/
│
└── analytics/
```

---

## Progress Tracker

### Completed

* [x] Create GitHub repository
* [x] Configure Git locally
* [x] Create Python virtual environment
* [x] Install dbt
* [x] Configure BigQuery service account
* [x] Create BigQuery datasets
* [x] Configure dbt profile
* [x] Create source definitions
* [x] Build `stg_orders`

### Next Steps

* [ ] Build `stg_users`
* [ ] Build `stg_products`
* [ ] Build `stg_order_items`
* [ ] Create fact tables
* [ ] Create dimension tables
* [ ] Create KPI layer
* [ ] Connect BI tool
* [ ] Final project documentation

```

### Key Reminder

When working with BigQuery public datasets, always verify that:
1. Source dataset region
2. Target dataset region
3. dbt execution location

all match before troubleshooting permissions.
```
