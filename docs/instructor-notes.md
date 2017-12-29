---
title: "MIDS w205 - Fundamentals of Data Engineering"
author: "Instructor Notes"

---

This is a compilation of notes for and by instructors.  It will mostly focus on
tools, images, and grading.  We'll work to keep this up-to-date as we progress
through the first semester that this course is taught.

This document is intended to be live and is maintained in the `course-content`
repository.


# GitHub

It's in our student's best interest that they develop a strong working
knowledge of `git` and GitHub.

We recommend that instructors:

- drive all course content via GitHub.  This includes access to synchronous
  session slides, links to async videos, and any notes, readings, and links

- use GitHub Classroom to manage activity assignment and submission

Each instructor has a GitHub Organization (`mids-w205-<instructor>`) to use for
all sections they teach.


# GitHub Classroom

## `tl;dr`

Each student assignment:

- has a corresponding private repo shared by the student and instructor

- is created from a template repository that contains any setup for the
  activity.  This allows us to include things like `Dockerfile`s and/or
  docker-compose templates directly within an activity

- is submitted as a pull request.  The grading process then consists of
  PR reviews

Note that this describes an _individual_ assignment, but _group_ assignments
work the same way, just using group access to an assignment repo.


## Creating Assignments

GitHub Classroom provides some tooling around assigning and submitting
solutions to student activities.  It's front-and-center in the GitHub Classroom
interface for the instructor and pretty transparent to the student.

Students can be added to an assignment through the GitHub Classroom UI, but
each assignment gets a unique link that's easily posted to a wall or pasted in
slack or chat.

### Creation Process

It's pretty much as simple as pick a name for the assignment and choose the
appropriate activity template.  I recommend marking them as `Private`,
_without_ student `Admin` access, and with no need for a deadline.  Marking
them as `Private` in this context means only the instructor and student have
access.  I'm not sure what happens with the deadline, I'll have to experiment.

Once the assignment is created, then existing students in the classroom can be
invited to participate in the activity.  You can always hand out the link to
the assignment in chat or on the wall for the class (like we'll do to bootstrap
classrooms with a trivial "signup" assignment).


## A Student's View

### Signup

TODO: include screenshots here

### Accepting an assignment

TODO: include screenshots here

### Submitting a solution to an assignment

An assignment submission is a pull-request on the student's repo for that
assignment.  Instructor/grader feedback then works like a review of that PR.

TODO: include screenshots here


## GitHub Classroom Setup

A GitHub classroom has already been created for each instructor organization.

Students will join the GitHub Classroom when they click the invite link to
accept the course's first "signup" assignment.  Students with GitHub accounts
will sign in with their existing accounts.  Students without GitHub accounts
will be able to create new personal accounts as part of that assignment
invitation.

### Rosters

I've added rosters from two of the sections into my GitHub Classroom.  All
that's really needed is a csv of `{ Last, First }`, which is enough to let
students self-select when they join the GitHub Classroom for their first
activity.  The "roster" then just becomes a mapping of names to GitHub logins.

### Assignments and activity templates

Every assignment should have an associated activity template (repository).  For
example, 

    mids-w205-fund-of-data-eng/template-activity-signup

or 

    mids-w205-fund-of-data-eng/template-activity-01

These are just a template repository for each activity that will be used
as the source when instantiating each student's assignment repo.

When creating new assignments, instructors can a.) simply use the
`mids-w205-fund-of-data-eng` templates provided or b.) create specialized
activity templates within their own orgs.


Check out <https://classroom.github.com/videos> for more info.


# Cloud Accounts

## AWS and GCP

Students will directly use a variety of AWS and GCP services throughout this
course.  We'll prefer that students create free-tier individual accounts with
AWS and GCP (we walk them through this process during the second class).  If a
student has already spent their free tier, there are potential sources of help
from the department.  Let's try to take that on a case-by-case basis.

## DigitalOcean

We have a DigitalOcean account for MIDS w205 instructors with resources
available to stand up an instance per-student for the duration of the
semester.

There's a MachineLearning One-Click (MLOC) image that provides a handful
of particularly useful tools for this class right out of the box:

- common python (2&3) ML tools and libraries
- common R tools and libraries
- jupyterhub
    - with terminal access!
    - `basic_auth` over bare `http`, so be careful
- r-studio server
    - `basic_auth` over bare `http`, so be careful
    

# Cloud and Container Images

TODO: Most of what we do will be included in the activity template repos,
but it's worth going over some basic requirements we have here.


# Keeping Things Fresh

In order to keep this course as up-to-date as possible, we've chosen to capture
the bulk of the course content as individually-created screencasts and use fewer
studio-recorded lectures.

There's also a good deal of the content for this course that is still under
various forms of construction... recording, editing, etc.
You'll see `under-construction.png` gaps.

To accommodate this, the `course-content` repo in your GitHub organization

    mids-w205-<instructor>/course-content

is a fork of the main development repo, 

    mids-w205-fund-of-data-eng/course-content

Please help throughout this process by keeping your fork up-to-date with this
"upstream" as the content is completed.

### Refresh from upstream

Here's a basic workflow to refresh from upstream

    git clone git@github.com:<my-org>/course-content
    cd course-content
    git remote add upstream git@github.com:mids-w205-fund-of-data-eng/course-content
    git pull --all
    git merge upstream/master
    git push origin master

