#!/usr/bin/env sh

echo Generating project $1

mkdir $1
cd $1

if django-admin startproject $1_backend && vue create $1_frontend; then
    cat >> .gitignore << EOF
*~
\#*
EOF
    cd $1_backend
    cat >> .env.example << EOF
SECRET_KEY="hellothere"
DEBUG="True"
DB_NAME=""
DB_USER="root"
DB_PASSWORD="root"
DB_HOST="localhost"
DB_PORT="3306"
ALLOWED_HOSTS="localhost"
EMAIL_HOST=""
EMAIL_HOST_USER=""
EMAIL_HOST_PASSWORD=""
EMAIL_PORT=""
EMAIL_USE_SSL=""
EOF
    cp .env.example .env
    pipenv --three
    pipenv install djangorestframework django-cors-headers mysqlclient python-dotenv
    sed -e '/import os/afrom dotenv import load_dotenv\nload_dotenv()'           \
        -e 's/^\(SECRET_KEY = \).*$/\1os.getenv("SECRET_KEY")/'                  \
        -e 's/^\(DEBUG = \).*$/\1bool(os.getenv("DEBUG"))/'                      \
        -e 's/^\(ALLOWED_HOSTS = \).*$/\1os.getenv("ALLOWED_HOSTS").split(",")/' \
        -e '/ALLOWED_HOSTS = .*/a\\nCORS_ORIGIN_ALLOW_ALL = True'                \
        $1_backend/settings.py > tmp.py
    mv tmp.py $1_backend/settings.py
    cat >> .gitignore << EOF
.env
*.pyc
__pycache__/
EOF
    cd ../$1_frontend
    cat >> .dir-locals.el << EOF
(
  (web-mode . ((web-mode-attr-indent-offset . 2)
                (web-mode-markup-indent-offset . 2)
                (web-mode-code-indent-offset . 2)
                (web-mode-css-indent-offset . 2)
                (web-mode-part-padding . 2)
                (web-mode-style-padding . 0)
                (web-mode-block-padding . 2)
                (web-mode-script-padding . 0))
    )
  )
EOF
fi
