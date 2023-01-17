# version should match https://pages.github.com/versions/
# note that ruby 3 causes weird problems with subdependencies
FROM ruby:2.7.4-slim-bullseye
ARG UID=1000 GID=1000

RUN apt-get update \
    && apt-get install -y build-essential dumb-init gcc zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

RUN groupadd --gid "$GID" jekyll \
    && useradd --uid "$UID" --gid "$GID" -m jekyll

USER jekyll
WORKDIR /home/jekyll
ENV GEM_HOME="/home/jekyll/gems" \
    PATH="/home/jekyll/gems/bin:$PATH"

RUN gem install bundler
RUN gem install jekyll -v '3.9.2'

WORKDIR /home/jekyll/site
COPY --chown=jekyll site/Gemfile site/Gemfile.lock ./
RUN BUNDLE_FROZEN=true bundle install

COPY --chown=jekyll site ./

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/bin/bash"]
