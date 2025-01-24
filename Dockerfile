# Use Node.js image with Linux support
FROM node:20

# Set the working directory inside the container
WORKDIR /app

# Copy package manager and lock files
COPY package.json pnpm-lock.yaml ./

# Copy the entire project into the container
COPY . .

# Install pnpm globally
RUN npm install -g pnpm

# Install project dependencies using pnpm
RUN pnpm install

# Install Foundry if required by foundry.toml
RUN curl -L https://foundry.paradigm.xyz | bash && \
    /root/.foundry/bin/foundryup

# Expose a default port (for Hardhat or other dev servers)
EXPOSE 8545

# Default command to run the Hardhat node
CMD ["pnpm", "hardhat", "node"]
