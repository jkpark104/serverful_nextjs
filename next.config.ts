import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  /* config options here */
  output: "standalone",
  assetPrefix: "https://d3sq5jpzoteont.cloudfront.net",
  images: {
    remotePatterns: [
      {
        protocol: "https",
        hostname: "d3sq5jpzoteont.cloudfront.net",
      },
    ],
  },
  generateBuildId: () => {
    return "BUILD_ID";
  },
};

export default nextConfig;
