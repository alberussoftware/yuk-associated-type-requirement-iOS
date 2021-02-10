//
//  c_context.h
//  YUKAssociatedTypeRequirement
//
//  Created by Ruslan Lutfullin on 2/9/21.
//

#ifndef c_context_h
#define c_context_h

static inline void set_self_pointer(void *pointer) {
#ifdef __aarch64__
  __asm__("mov x20, x0");
#endif
#ifdef __x86_64__
  __asm__("movq %rdi, %r13");
#endif
}

#endif /* c_context_h */
