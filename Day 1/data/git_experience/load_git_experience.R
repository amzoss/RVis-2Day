library(tidyverse)

git_experience <- read_csv('data/git_experience/2020-07-12_processed-survey.csv') %>%
  #dplyr::select(-X1) %>% # For older versions of readr
  dplyr::select(-`...1`) %>%
  mutate(year_vcs = as.numeric(year_vcs),
         across(.cols = c(first_bazaar, first_cvs, first_git, first_hg,
                          first_monotone, first_svn, first_other, use_bitbucket,
                          use_github, use_gitlab, use_sourceforge, use_selfhost,
                          use_nothing, use_other_platform, use_local_gui,
                          use_local_term, use_local_other, how_learn_books,
                          how_learn_credit_course, how_learn_online_course,
                          how_learn_rtfm, how_learn_accel, how_learn_webinar,
                          how_learn_workshop, how_learn_other, teach_inperson,
                          teach_vasync, teach_vsync, use_ci, use_annotation,
                          use_fork_pr, use_issues, use_pages, use_boards,
                          use_wikis, use_other_feat, private_fund, public_fund,
                          dontknow_fund, no_funds, other_fund, scholexp_collab,
                          scholexp_edu, scholexp_method, scholexp_peerprod,
                          scholexp_peer_review, scholexp_pub, scholexp_qa,
                          scholexp_repro, scholexp_other, archive_figshare,
                          archive_ir, archive_osf, archive_sh, archive_zenodo,
                          archive_other),
                as.logical))
