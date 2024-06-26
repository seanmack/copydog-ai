# What is CopydogAI?

CopydogAI is a brand new project. It will allow a user to pull in an
existing web page's content. The user can then "clean up" the
content and make it available via an API for other applications to use.

## How?

CopydogAI scrapes the content from a web page, sanitizes it by removing
unwanted elements, then sends it to OpenAI's API for further processing.

The result is a clean, well-formatted version of the original content that
can be used in a variety of ways.

## Why?

I've worked with a number of different CMSs and I've found that
importing content from one system to another can be a real pain:
* Sometimes you don't want to import everything, just the primary content.
* Sometimes you want to fix the content before importing it, e.g. to remove
  broken links or to reformat the text.
* Sometimes you want to clone some external site's content and use it as a
  starting point for building a new original page

CopydogAI will make it easy to do all of these things.

## Project Status

CopydogAI is currently in the initial stages of development. I'm working on
building out the core functionality and getting the basic API up and running.

The best way to follow along with the project is to check out the pull requests,
which will show you the latest changes and updates.

* **Phase #1 (current)**: Build out the basic features using an MVP approach

* **Phase #2**: Build out the API and add additional features

* **Phase #3**: Add a front-end interface for users to interact with the system


## Setup

The system requirements are still being determined. For now, you'll need:
* Postgres running on your local machine
* Ruby 3.2.1

### Getting Started

1. Clone this repository
1. `bin/setup`
1. Run the specs: `rspec`
1. `cp example.env .env`
1. Add your OpenAI API key to the `.env` file
1. Run the server: `rails s`
1. Visit `http://localhost:3000` in your browser
