# Step 1: Use a base image
FROM node:18-alpine

# Step 2: Set working directory inside container
WORKDIR /app

# Step 3: Copy dependency files first (for efficient caching)
COPY package*.json ./

# Step 4: Install dependencies
RUN npm install

# Step 5: Copy rest of the application code
COPY . .

# Step 6: Expose port (for networking)
EXPOSE 3000

# Step 7: Set the default command to run the app
CMD ["npm", "start"]

