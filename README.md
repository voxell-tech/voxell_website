# Voxell Website

Source for the [voxell.dev](https://voxell.dev) website, built with
[Tola](https://github.com/tola-rs/tola-ssg) 0.8 and
[Tailwind CSS v4](https://tailwindcss.com) on the project site kit in
[`voxell_web_shared`](https://github.com/voxell-tech/voxell_web_shared)
(the `shared/` submodule).

## Prerequisites

Tola, from the commit CI builds with (`TOLA_REV` in
`.github/workflows/deploy.yml`):

```sh
cargo install --locked --git https://github.com/tola-rs/tola-ssg --rev 98f5c290da96192c8cb18704a51cf28d7285559a tola
```

Tailwind CSS (`package.json` is already set up), with node on `PATH`:

```sh
npm install
npm install -g @tailwindcss/cli
git submodule update --init
```

## Development

Start a local dev server with live reload at <http://127.0.0.1:5277>:

```sh
tola dev
```

## Building

Produce a production build in `public/`:

```sh
tola build
```

## Deployment

Pushing to `main` runs `.github/workflows/deploy.yml`, which builds the
site and deploys `public/` to GitHub Pages.

## Project structure

```
site.typ            # Entry: hands project.typ to the shared kit
project.typ         # Nav, brand and SEO settings for the kit
data/projects.typ   # Every project: blurb, image, tags, star snapshot
content/
  index.typ         # Home: voxel hero, project bento, crates, community
  projects/         # /projects/
  roadmaps/         # /roadmaps/, open issues from GitHub
  404.typ
components/
  visuals.typ       # Project tiles, crate chips, section headings
assets/
  js/voxels.js      # The hero's voxel field (Canvas 2D)
  js/stars.js       # Live GitHub star and repo counts
  js/roadmaps.js    # Roadmap tabs, issue cards and modal
  images/projects/  # Project screenshots
  styles/           # Tailwind CSS entry point
scripts/
  og-image.typ      # Social preview card (assets/images/og.png)
```
