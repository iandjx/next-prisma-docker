#!/bin/bash
npm prisma migrate deploy
node server.js:w
