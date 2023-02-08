workspace(
    name = "monorepo",
)

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "aspect_bazel_lib",
    sha256 = "79623d656aa23ad3fd4692ab99786c613cd36e49f5566469ed97bc9b4c655f03",
    strip_prefix = "bazel-lib-1.23.3",
    url = "https://github.com/aspect-build/bazel-lib/archive/refs/tags/v1.23.3.tar.gz",
)

load("@aspect_bazel_lib//lib:repositories.bzl", "aspect_bazel_lib_dependencies")

aspect_bazel_lib_dependencies()

# NODEJS rules
http_archive(
    name = "aspect_rules_js",
    sha256 = "b3012692407d5eb2509cebdca2ece6eb0300885514e4034c20c2882c0e13c39d",
    strip_prefix = "rules_js-1.18.0",
    url = "https://github.com/aspect-build/rules_js/releases/download/v1.18.0/rules_js-v1.18.0.tar.gz",
)

http_archive(
    name = "aspect_rules_ts",
    sha256 = "7d964d57c6e9a54b0ce20f27e5ea84e5b42b6db2148ab7eb18d7110a082380de",
    strip_prefix = "rules_ts-1.2.4",
    url = "https://github.com/aspect-build/rules_ts/releases/download/v1.2.4/rules_ts-v1.2.4.tar.gz",
)

http_archive(
    name = "aspect_rules_jest",
    sha256 = "9f327ea58950c88274ea7243419256c74ae29a55399d2f5964eb7686c7a5660d",
    strip_prefix = "rules_jest-0.15.0",
    url = "https://github.com/aspect-build/rules_jest/archive/refs/tags/v0.15.0.tar.gz",
)

load("@aspect_rules_js//js:repositories.bzl", "rules_js_dependencies")

rules_js_dependencies()

load("@aspect_rules_ts//ts:repositories.bzl", "rules_ts_dependencies")

rules_ts_dependencies(ts_version_from = "//src/nodejs:package.json")

load("@aspect_rules_jest//jest:dependencies.bzl", "rules_jest_dependencies")

rules_jest_dependencies()

load("@aspect_rules_jest//jest:repositories.bzl", "jest_repositories")

jest_repositories(name = "jest")

load("@jest//:npm_repositories.bzl", jest_npm_repositories = "npm_repositories")

jest_npm_repositories()

load("@rules_nodejs//nodejs:repositories.bzl", "DEFAULT_NODE_VERSION", "nodejs_register_toolchains")

nodejs_register_toolchains(
    name = "nodejs",
    node_version = DEFAULT_NODE_VERSION,
)

load("@aspect_rules_js//npm:npm_import.bzl", "npm_translate_lock")

npm_translate_lock(
    name = "npm",
    bins = {
        # derived from "bin" attribute in node_modules/typescript/package.json
        "typescript": {
            "tsc": "./bin/tsc",
            "tsserver": "./bin/tsserver",
        },
        # derived from "bin" attribute in node_modules/next/package.json
        "next": {
            "next": "./dist/bin/next",
        },
        # derived from "bin" attribute in node_modules/eslint/package.json
        "eslint": {
            "eslint": "./bin/eslint.js",
        },
    },
    data = [
        "//src/nodejs:.npmrc",
        "//src/nodejs:package.json",
        "//src/nodejs:pnpm-lock.yaml",
        "//src/nodejs:pnpm-workspace.yaml",
        "//src/nodejs/libraries/example_lib:package.json",
    ],
    external_repository_action_cache = "src/nodejs/.aspect/external_repository_action_cache",
    npmrc = "//src/nodejs:.npmrc",
    pnpm_lock = "//src/nodejs:pnpm-lock.yaml",
    public_hoist_packages = {
        "eslint": [""],
    },
    update_pnpm_lock = True,
    verify_node_modules_ignored = "//:.bazelignore",
)

load("@npm//:repositories.bzl", "npm_repositories")

npm_repositories()
