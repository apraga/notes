;; Generate a static website using org publish mechanism
;; We use hakyll instead, just keep it for old time sake

;; Minimal config, see https://systemcrafters.net/publishing-websites-with-org-mode/building-the-site/
;; for the complete configuration

;; Load the publishing system
(require 'ox-publish)

;; ;; Customize the HTML output
(setq org-html-validation-link nil            ;; Don't show validation link
;;       org-html-head-include-scripts nil       ;; Use our own scripts
;;       org-html-head-include-default-style nil ;; Use our own styles
;;       org-html-head "<link rel=\"stylesheet\" href=\"https://cdn.simplecss.org/simple.min.css\" />")
      )

;; ;; Which files to publish ?
(setq org-publish-project-alist
      '(("genetique-notes"
         :recursive nil
         :base-directory "genetique"
         :publishing-directory "html/genetique"
         :author nil
         :section-numbers nil
         :publishing-function org-html-publish-to-html)
        ("genetique-img"
         :base-directory "genetique/img"
         :base-extension "png\\|jpg"
         :publishing-directory "html/genetique/img"
         :publishing-function org-publish-attachment)
        ("genetique" :components ("genetique-notes" "genetique-img"))
        ("posts"
         :base-directory "posts/"
         :base-extension "org"
         :publishing-directory "html/"
         :recursive t
         :publishing-function org-html-publish-to-html
         :auto-sitemap t
         :sitemap-filename "index.html"
         :sitemap-title "Armadillo"
         :author "Alexis Praga"
         :with-toc nil)
        ("all" :components ("genetique" "posts"))))


;; Generate the site output
;; (org-publish-all t) ; force everything
(org-publish-all) ; do not force

(message "Build complete!")