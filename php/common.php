<?php

    public function escapeBeginningAtmark($value) {
        return preg_replace("/^@/", "＠", $value);
    }

    public function isBeginningAtmark($value) {
        return preg_match("/^@/", $value);
    }
