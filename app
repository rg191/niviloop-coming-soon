import { useState, Suspense, lazy, useMemo } from 'react';
import { motion, AnimatePresence } from 'motion/react';
import { OptimizedBackgroundShapes } from './components/OptimizedBackgroundShapes';
import { OptimizedCountdownTimer } from './components/OptimizedCountdownTimer';
import { OptimizedAnimatedLogo } from './components/OptimizedAnimatedLogo';

// Lazy load heavy components for better initial load performance
const OptimizedFloatingParticles = lazy(() => import('./components/OptimizedFloatingParticles').then(module => ({ default: module.OptimizedFloatingParticles })));
const OptimizedInteractiveBackground = lazy(() => import('./components/OptimizedInteractiveBackground').then(module => ({ default: module.OptimizedInteractiveBackground })));
import { Button } from './components/ui/button';
import { Input } from './components/ui/input';
import { Linkedin, Mail, ArrowRight } from 'lucide-react';

export default function App() {
  const [email, setEmail] = useState('');
  const [isSubscribed, setIsSubscribed] = useState(false);

  // Memoize animation variants for better performance
  const animationVariants = useMemo(() => ({
    heroCard: {
      initial: { opacity: 0, y: 30, scale: 0.95 },
      animate: { opacity: 1, y: 0, scale: 1 },
      transition: { duration: 0.6, ease: "easeOut" }
    },
    headline: {
      initial: { opacity: 0, y: 20 },
      animate: { opacity: 1, y: 0 },
      transition: { delay: 0.3, duration: 0.6 }
    },
    subtext: {
      initial: { opacity: 0, y: 15 },
      animate: { opacity: 1, y: 0 },
      transition: { delay: 0.8, duration: 0.5 }
    },
    form: {
      initial: { opacity: 0, y: 20 },
      animate: { opacity: 1, y: 0 },
      transition: { delay: 1, duration: 0.5 }
    },
    footer: {
      initial: { opacity: 0, y: 30 },
      animate: { opacity: 1, y: 0 },
      transition: { delay: 1.5, duration: 0.5 }
    }
  }), []);

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    if (email) {
      setIsSubscribed(true);
      // Here you would typically send the email to hello@niviloop.com
      console.log('Email submitted to hello@niviloop.com:', email);
      
      // Mock email sending functionality
      // In production, you'd send this to your backend which would forward to hello@niviloop.com
    }
  };

  return (
    <div className="min-h-screen relative overflow-hidden font-['Inter',_'SF_Pro_Display',_system-ui,_sans-serif]">
      <OptimizedBackgroundShapes />
      
      {/* Lazy load heavy animation components */}
      <Suspense fallback={null}>
        <OptimizedFloatingParticles />
        <OptimizedInteractiveBackground />
      </Suspense>
      
      {/* Main Content */}
      <div className="relative z-10 min-h-screen flex flex-col">
        {/* Hero Section */}
        <main className="flex-1 flex items-center justify-center px-6 py-12">
          <div className="w-full max-w-2xl">
            {/* Frosted Glass Hero Card */}
            <motion.div 
              className="bg-white/10 backdrop-blur-xl rounded-[24px] p-10 border border-white/20 shadow-2xl shadow-black/20 relative overflow-hidden group will-change-transform"
              variants={animationVariants.heroCard}
              initial="initial"
              animate="animate"
              whileHover={{ 
                scale: 1.01,
                boxShadow: "0 25px 50px -12px rgba(0, 0, 0, 0.4), 0 0 0 1px rgba(164, 255, 79, 0.1)"
              }}
            >
              {/* Simplified border glow - no infinite animation */}
              <div className="absolute inset-0 rounded-[24px] border border-[#A4FF4F]/20 opacity-0 group-hover:opacity-100 transition-opacity duration-300" />

              {/* Logo */}
              <OptimizedAnimatedLogo />

              {/* Main Headline */}
              <motion.div 
                className="text-center mb-6"
                variants={animationVariants.headline}
                initial="initial"
                animate="animate"
              >
                <motion.h2 
                  className="text-4xl md:text-5xl font-light text-white mb-4 tracking-tight"
                  initial={{ opacity: 0, scale: 0.9 }}
                  animate={{ opacity: 1, scale: 1 }}
                  transition={{ delay: 0.5, duration: 0.6, ease: "easeOut" }}
                >
                  Coming Soon
                </motion.h2>
                
                <motion.p 
                  className="text-lg text-white/80 leading-relaxed max-w-lg mx-auto"
                  variants={animationVariants.subtext}
                  initial="initial"
                  animate="animate"
                >
                  <span className="hover:text-[#A4FF4F] transition-colors duration-200 cursor-default">
                    AI-driven business growth.
                  </span>{' '}
                  <span className="hover:text-[#A4FF4F] transition-colors duration-200 cursor-default">
                    Strategy.
                  </span>{' '}
                  <span className="hover:text-[#A4FF4F] transition-colors duration-200 cursor-default">
                    Automation.
                  </span>{' '}
                  <span className="hover:text-[#A4FF4F] transition-colors duration-200 cursor-default">
                    Compliance.
                  </span>
                </motion.p>
              </motion.div>

              {/* Countdown Timer */}
              <OptimizedCountdownTimer />

              {/* Email Subscription Form */}
              <motion.div 
                className="mt-8"
                variants={animationVariants.form}
                initial="initial"
                animate="animate"
              >
                <AnimatePresence mode="wait">
                  {!isSubscribed ? (
                    <motion.form 
                      onSubmit={handleSubmit} 
                      className="flex flex-col sm:flex-row gap-4 max-w-md mx-auto"
                      initial={{ opacity: 0, scale: 0.9 }}
                      animate={{ opacity: 1, scale: 1 }}
                      exit={{ opacity: 0, scale: 0.9 }}
                      transition={{ duration: 0.3 }}
                    >
                      <motion.div className="flex-1 relative">
                        <Mail className="absolute left-4 top-1/2 transform -translate-y-1/2 text-white/50 w-5 h-5" />
                        <Input
                          type="email"
                          placeholder="Enter your email"
                          value={email}
                          onChange={(e) => setEmail(e.target.value)}
                          required
                          className="bg-white/10 backdrop-blur-sm border-white/20 rounded-2xl pl-12 pr-6 py-4 text-white placeholder:text-white/50 focus:border-[#A4FF4F] focus:ring-[#A4FF4F]/20 transition-all duration-300"
                        />
                      </motion.div>
                      
                      <motion.div
                        whileHover={{ scale: 1.05 }}
                        whileTap={{ scale: 0.95 }}
                      >
                        <Button
                          type="submit"
                          className="bg-[#A4FF4F] hover:bg-[#A4FF4F]/90 text-black font-medium px-6 py-3 rounded-xl transition-all duration-200 hover:shadow-lg hover:shadow-[#A4FF4F]/20 group relative will-change-transform"
                        >
                          <span className="relative z-10 flex items-center gap-2">
                            Notify Me
                            <ArrowRight className="w-4 h-4 group-hover:translate-x-1 transition-transform duration-200" />
                          </span>
                        </Button>
                      </motion.div>
                    </motion.form>
                  ) : (
                    <motion.div 
                      className="text-center"
                      initial={{ opacity: 0, scale: 0.8 }}
                      animate={{ opacity: 1, scale: 1 }}
                      transition={{ duration: 0.5 }}
                    >
                      <div className="inline-flex items-center gap-3 bg-[#A4FF4F]/20 backdrop-blur-sm rounded-xl px-6 py-3 border border-[#A4FF4F]/30">
                        <div className="w-2 h-2 bg-[#A4FF4F] rounded-full animate-pulse" />
                        <span className="text-white font-medium">Thank you! We'll be in touch.</span>
                      </div>
                    </motion.div>
                  )}
                </AnimatePresence>
              </motion.div>
            </motion.div>
          </div>
        </main>

        {/* Footer */}
        <motion.footer 
          className="relative z-10 py-6 px-6"
          variants={animationVariants.footer}
          initial="initial"
          animate="animate"
        >
          <div className="max-w-6xl mx-auto">
            <motion.div 
              className="bg-white/5 backdrop-blur-sm rounded-2xl px-8 py-6 border border-white/10 relative overflow-hidden group"
              whileHover={{ 
                backgroundColor: 'rgba(255, 255, 255, 0.08)',
                borderColor: 'rgba(164, 255, 79, 0.2)'
              }}
              transition={{ duration: 0.3 }}
            >
              {/* Subtle glow effect */}
              <motion.div
                className="absolute inset-0 bg-gradient-to-r from-[#A4FF4F]/5 via-transparent to-[#A4FF4F]/5 opacity-0 group-hover:opacity-100"
                transition={{ duration: 0.3 }}
              />
              
              <div className="flex flex-col sm:flex-row items-center justify-between gap-4 relative z-10">
                {/* Links */}
                <div className="flex items-center gap-6">
                  <motion.a
                    href="#"
                    className="text-white/70 hover:text-white transition-colors duration-200 text-sm relative"
                    whileHover={{ scale: 1.05, color: '#A4FF4F' }}
                    transition={{ duration: 0.2 }}
                  >
                    GDPR
                    <motion.div
                      className="absolute bottom-0 left-0 w-full h-px bg-[#A4FF4F] scale-x-0 origin-left"
                      whileHover={{ scaleX: 1 }}
                      transition={{ duration: 0.2 }}
                    />
                  </motion.a>
                  
                  <motion.div 
                    className="w-px h-4 bg-white/20"
                    animate={{ 
                      height: [16, 20, 16],
                      opacity: [0.2, 0.4, 0.2]
                    }}
                    transition={{
                      duration: 3,
                      repeat: Infinity,
                      ease: "easeInOut"
                    }}
                  />
                  
                  <motion.a
                    href="#"
                    className="text-white/70 hover:text-white transition-colors duration-200 text-sm relative"
                    whileHover={{ scale: 1.05, color: '#A4FF4F' }}
                    transition={{ duration: 0.2 }}
                  >
                    Imprint
                    <motion.div
                      className="absolute bottom-0 left-0 w-full h-px bg-[#A4FF4F] scale-x-0 origin-left"
                      whileHover={{ scaleX: 1 }}
                      transition={{ duration: 0.2 }}
                    />
                  </motion.a>
                </div>

                {/* Social */}
                <div className="flex items-center gap-4">
                  <motion.a
                    href="#"
                    className="text-white/70 hover:text-white transition-colors duration-200 p-3 rounded-xl hover:bg-white/10 relative group"
                    aria-label="LinkedIn"
                    whileHover={{ 
                      scale: 1.1,
                      backgroundColor: 'rgba(164, 255, 79, 0.1)',
                      color: '#A4FF4F'
                    }}
                    whileTap={{ scale: 0.95 }}
                    transition={{ duration: 0.2 }}
                  >
                    <Linkedin size={20} />
                    
                    {/* Pulse effect on hover */}
                    <motion.div
                      className="absolute inset-0 rounded-xl border-2 border-[#A4FF4F] opacity-0 group-hover:opacity-30"
                      animate={{
                        scale: [1, 1.2, 1],
                      }}
                      transition={{
                        duration: 1.5,
                        repeat: Infinity,
                        ease: "easeInOut"
                      }}
                    />
                  </motion.a>
                </div>
              </div>
            </motion.div>
          </div>
        </motion.footer>
      </div>
    </div>
  );
}
