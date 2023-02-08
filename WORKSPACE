workspace(
    name = "monorepo",
)

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "aspect_bazel_lib",
    sha256 = "ef83252dea2ed8254c27e65124b756fc9476be2b73a7799b7a2a0935937fc573",
    strip_prefix = "bazel-lib-1.24.2",
    url = "https://github.com/aspect-build/bazel-lib/releases/download/v1.24.2/bazel-lib-v1.24.2.tar.gz",
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

load("@aspect_rules_js//js:repositories.bzl", "rules_js_dependencies")

rules_js_dependencies()

load("@aspect_rules_ts//ts:repositories.bzl", "rules_ts_dependencies")

rules_ts_dependencies(ts_version_from = "//src/nodejs:package.json")

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
